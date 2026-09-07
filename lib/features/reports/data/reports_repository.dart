import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../database/app_database.dart';

class SaleHistoryEntry {
  const SaleHistoryEntry({required this.sale, this.reversal});

  final Sale sale;
  final SaleReversal? reversal;
  bool get isReversed => reversal != null;
}

class ReportSummary {
  const ReportSummary({
    required this.sales,
    required this.cost,
    required this.grossProfit,
    required this.expenses,
    required this.orders,
  });
  final int sales;
  final int cost;
  final int grossProfit;
  final int expenses;
  final int orders;
  int get netProfit => grossProfit - expenses;
  int get marginBasisPoints =>
      sales == 0 ? 0 : ((grossProfit * 10000) / sales).round();
}

class ReportsRepository {
  ReportsRepository(this._database, {String Function()? generateId})
    : _generateId = generateId ?? const Uuid().v4;
  final AppDatabase _database;
  final String Function() _generateId;

  Stream<List<SaleHistoryEntry>> watchSales() {
    final query = _database.select(_database.sales).join([
      leftOuterJoin(
        _database.saleReversals,
        _database.saleReversals.saleId.equalsExp(_database.sales.id),
      ),
    ])..orderBy([OrderingTerm.desc(_database.sales.completedAt)]);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => SaleHistoryEntry(
              sale: row.readTable(_database.sales),
              reversal: row.readTableOrNull(_database.saleReversals),
            ),
          )
          .toList(growable: false),
    );
  }

  Stream<ReportSummary> watchSummary(DateTime from, DateTime until) {
    final salesQuery =
        _database.select(_database.sales).join([
          leftOuterJoin(
            _database.saleReversals,
            _database.saleReversals.saleId.equalsExp(_database.sales.id),
          ),
        ])..where(
          _database.sales.completedAt.isBetweenValues(from, until) &
              _database.saleReversals.saleId.isNull(),
        );
    final expenseQuery = _database.select(_database.expenses)
      ..where((t) => t.expenseDate.isBetweenValues(from, until));
    return salesQuery.watch().asyncExpand(
      (rows) => expenseQuery.watch().map(
        (expenses) => ReportSummary(
          sales: rows.fold(
            0,
            (sum, row) => sum + row.readTable(_database.sales).totalAmount,
          ),
          cost: rows.fold(
            0,
            (sum, row) => sum + row.readTable(_database.sales).totalCost,
          ),
          grossProfit: rows.fold(
            0,
            (sum, row) => sum + row.readTable(_database.sales).profit,
          ),
          expenses: expenses.fold(0, (sum, expense) => sum + expense.amount),
          orders: rows.length,
        ),
      ),
    );
  }

  Future<List<SaleItem>> saleItems(String saleId) => (_database.select(
    _database.saleItems,
  )..where((t) => t.saleId.equals(saleId))).get();

  Stream<List<ProductPerformance>> watchProductPerformance(
    DateTime from,
    DateTime until,
  ) {
    final query =
        _database.select(_database.saleItems).join([
          innerJoin(
            _database.sales,
            _database.sales.id.equalsExp(_database.saleItems.saleId),
          ),
          leftOuterJoin(
            _database.saleReversals,
            _database.saleReversals.saleId.equalsExp(_database.sales.id),
          ),
        ])..where(
          _database.sales.completedAt.isBetweenValues(from, until) &
              _database.saleReversals.saleId.isNull(),
        );
    return query.watch().map((rows) {
      final grouped = <String, ProductPerformance>{};
      for (final row in rows) {
        final item = row.readTable(_database.saleItems);
        final old = grouped[item.productId];
        grouped[item.productId] = ProductPerformance(
          productName: item.productName,
          quantity: (old?.quantity ?? 0) + item.quantity,
          revenue: (old?.revenue ?? 0) + item.lineTotal,
          profit: (old?.profit ?? 0) + item.lineProfit,
        );
      }
      return grouped.values.toList()
        ..sort((a, b) => b.revenue.compareTo(a.revenue));
    });
  }

  Future<SaleReversal> reverseSale({
    required String saleId,
    required String reversalType,
    required String reason,
  }) async {
    final cleanReason = reason.trim();
    if (reversalType != 'CANCELLATION' && reversalType != 'REFUND') {
      throw const ValidationException('Select Cancellation or Refund.');
    }
    if (cleanReason.length < 3 || cleanReason.length > 250) {
      throw const ValidationException(
        'Enter a reason between 3 and 250 characters.',
      );
    }
    return _database.transaction(() async {
      final sale = await (_database.select(
        _database.sales,
      )..where((table) => table.id.equals(saleId))).getSingleOrNull();
      if (sale == null) {
        throw const ValidationException('Sale does not exist.');
      }
      final existing = await (_database.select(
        _database.saleReversals,
      )..where((table) => table.saleId.equals(saleId))).getSingleOrNull();
      if (existing != null) {
        throw const ValidationException('This sale was already reversed.');
      }
      final movements =
          await (_database.select(_database.inventoryMovements)..where(
                (table) =>
                    table.referenceId.equals(saleId) &
                    table.movementType.equals('SALE'),
              ))
              .get();
      final reversedAt = DateTime.now();
      for (final movement in movements) {
        final inventory =
            await (_database.select(_database.inventoryItems)
                  ..where((table) => table.id.equals(movement.inventoryItemId)))
                .getSingle();
        final restoredQuantity = -movement.quantity;
        final quantityAfter = inventory.stockQuantity + restoredQuantity;
        await (_database.update(
          _database.inventoryItems,
        )..where((table) => table.id.equals(inventory.id))).write(
          InventoryItemsCompanion(
            stockQuantity: Value(quantityAfter),
            updatedAt: Value(reversedAt),
          ),
        );
        await _database
            .into(_database.inventoryMovements)
            .insert(
              InventoryMovementsCompanion.insert(
                id: _generateId(),
                inventoryItemId: inventory.id,
                movementType: 'ADD',
                quantity: restoredQuantity,
                quantityBefore: inventory.stockQuantity,
                quantityAfter: quantityAfter,
                referenceType: Value(
                  reversalType == 'REFUND'
                      ? 'SALE_REFUND'
                      : 'SALE_CANCELLATION',
                ),
                referenceId: Value(saleId),
              ),
            );
      }
      final id = _generateId();
      await _database
          .into(_database.saleReversals)
          .insert(
            SaleReversalsCompanion.insert(
              id: id,
              saleId: saleId,
              reversalType: reversalType,
              reason: cleanReason,
              reversedAt: reversedAt,
            ),
          );
      return (_database.select(
        _database.saleReversals,
      )..where((table) => table.id.equals(id))).getSingle();
    });
  }
}

class ProductPerformance {
  const ProductPerformance({
    required this.productName,
    required this.quantity,
    required this.revenue,
    required this.profit,
  });
  final String productName;
  final int quantity;
  final int revenue;
  final int profit;
}
