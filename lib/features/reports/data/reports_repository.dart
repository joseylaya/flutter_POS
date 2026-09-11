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

class SaleHistoryPage {
  const SaleHistoryPage({required this.items, required this.hasNext});

  final List<SaleHistoryEntry> items;
  final bool hasNext;
}

class ReportSummary {
  const ReportSummary({
    required this.sales,
    required this.cost,
    required this.grossProfit,
    required this.expenses,
    required this.orders,
    required this.itemsSold,
  });
  final int sales;
  final int cost;
  final int grossProfit;
  final int expenses;
  final int orders;
  final int itemsSold;
  int get netProfit => grossProfit - expenses;
  int get marginBasisPoints =>
      sales == 0 ? 0 : ((grossProfit * 10000) / sales).round();
}

class ReportsRepository {
  ReportsRepository(this._database, {String Function()? generateId})
    : _generateId = generateId ?? const Uuid().v4;
  final AppDatabase _database;
  final String Function() _generateId;

  Stream<SaleHistoryPage> watchSalesPage({
    required int page,
    required int pageSize,
    required DateTime from,
    required DateTime until,
  }) {
    assert(page >= 0);
    assert(pageSize > 0);
    final query =
        _database.select(_database.sales).join([
            leftOuterJoin(
              _database.saleReversals,
              _database.saleReversals.saleId.equalsExp(_database.sales.id),
            ),
          ])
          ..where(
            _database.sales.completedAt.isBiggerOrEqualValue(from) &
                _database.sales.completedAt.isSmallerThanValue(until),
          )
          ..orderBy([OrderingTerm.desc(_database.sales.completedAt)])
          ..limit(pageSize + 1, offset: page * pageSize);
    return query.watch().map((rows) {
      final hasNext = rows.length > pageSize;
      return SaleHistoryPage(
        hasNext: hasNext,
        items: rows
            .take(pageSize)
            .map(
              (row) => SaleHistoryEntry(
                sale: row.readTable(_database.sales),
                reversal: row.readTableOrNull(_database.saleReversals),
              ),
            )
            .toList(growable: false),
      );
    });
  }

  Stream<ReportSummary> watchSummary(DateTime from, DateTime until) {
    final salesQuery =
        _database.select(_database.sales).join([
          leftOuterJoin(
            _database.saleItems,
            _database.saleItems.saleId.equalsExp(_database.sales.id),
          ),
          leftOuterJoin(
            _database.saleReversals,
            _database.saleReversals.saleId.equalsExp(_database.sales.id),
          ),
        ])..where(
          _database.sales.completedAt.isBiggerOrEqualValue(from) &
              _database.sales.completedAt.isSmallerThanValue(until) &
              _database.saleReversals.saleId.isNull(),
        );
    final expenseQuery = _database.select(_database.expenses)
      ..where(
        (t) =>
            t.expenseDate.isBiggerOrEqualValue(from) &
            t.expenseDate.isSmallerThanValue(until),
      );
    return salesQuery.watch().asyncExpand(
      (rows) => expenseQuery.watch().map((expenses) {
        final sales = <String, Sale>{};
        var itemsSold = 0;
        for (final row in rows) {
          final sale = row.readTable(_database.sales);
          sales[sale.id] = sale;
          itemsSold += row.readTableOrNull(_database.saleItems)?.quantity ?? 0;
        }
        return ReportSummary(
          sales: sales.values.fold(0, (sum, sale) => sum + sale.totalAmount),
          cost: sales.values.fold(0, (sum, sale) => sum + sale.totalCost),
          grossProfit: sales.values.fold(0, (sum, sale) => sum + sale.profit),
          expenses: expenses.fold(0, (sum, expense) => sum + expense.amount),
          orders: sales.length,
          itemsSold: itemsSold,
        );
      }),
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
        _database.select(_database.sales).join([
          leftOuterJoin(
            _database.saleItems,
            _database.saleItems.saleId.equalsExp(_database.sales.id),
          ),
          leftOuterJoin(
            _database.saleReversals,
            _database.saleReversals.saleId.equalsExp(_database.sales.id),
          ),
        ])..where(
          _database.sales.completedAt.isBiggerOrEqualValue(from) &
              _database.sales.completedAt.isSmallerThanValue(until) &
              _database.saleReversals.saleId.isNull(),
        );
    return query.watch().map((rows) {
      final sales = <String, _SalePerformanceData>{};
      for (final row in rows) {
        final sale = row.readTable(_database.sales);
        final data = sales.putIfAbsent(
          sale.id,
          () => _SalePerformanceData(sale),
        );
        final item = row.readTableOrNull(_database.saleItems);
        if (item != null) data.items.add(item);
      }
      final grouped = <String, ProductPerformance>{};
      for (final data in sales.values) {
        if (data.items.isEmpty) {
          _addPerformance(
            grouped,
            key: 'unallocated',
            productName: 'Unallocated historical sales',
            quantity: 0,
            revenue: data.sale.totalAmount,
            profit: data.sale.profit,
          );
          continue;
        }
        final lineRevenue = data.items.fold<int>(
          0,
          (sum, item) => sum + item.lineTotal,
        );
        final quantityWeight = data.items.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );
        final weightTotal = lineRevenue > 0 ? lineRevenue : quantityWeight;
        var allocatedRevenue = 0;
        var allocatedProfit = 0;
        for (var index = 0; index < data.items.length; index++) {
          final item = data.items[index];
          final isLast = index == data.items.length - 1;
          final weight = lineRevenue > 0 ? item.lineTotal : item.quantity;
          final revenue = isLast
              ? data.sale.totalAmount - allocatedRevenue
              : (data.sale.totalAmount * weight) ~/ weightTotal;
          final profit = isLast
              ? data.sale.profit - allocatedProfit
              : (data.sale.profit * weight) ~/ weightTotal;
          allocatedRevenue += revenue;
          allocatedProfit += profit;
          _addPerformance(
            grouped,
            key: item.productId,
            productName: item.productName,
            quantity: item.quantity,
            revenue: revenue,
            profit: profit,
          );
        }
      }
      return grouped.values.toList()
        ..sort((a, b) => b.revenue.compareTo(a.revenue));
    });
  }

  void _addPerformance(
    Map<String, ProductPerformance> grouped, {
    required String key,
    required String productName,
    required int quantity,
    required int revenue,
    required int profit,
  }) {
    final old = grouped[key];
    grouped[key] = ProductPerformance(
      productName: productName,
      quantity: (old?.quantity ?? 0) + quantity,
      revenue: (old?.revenue ?? 0) + revenue,
      profit: (old?.profit ?? 0) + profit,
    );
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

class _SalePerformanceData {
  _SalePerformanceData(this.sale);

  final Sale sale;
  final List<SaleItem> items = [];
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
