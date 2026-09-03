import 'package:drift/drift.dart';

import '../../../database/app_database.dart';

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
  ReportsRepository(this._database);
  final AppDatabase _database;

  Stream<List<Sale>> watchSales() => (_database.select(
    _database.sales,
  )..orderBy([(t) => OrderingTerm.desc(t.completedAt)])).watch();

  Stream<ReportSummary> watchSummary(DateTime from, DateTime until) {
    final salesQuery = _database.select(_database.sales)
      ..where((t) => t.completedAt.isBetweenValues(from, until));
    final expenseQuery = _database.select(_database.expenses)
      ..where((t) => t.expenseDate.isBetweenValues(from, until));
    return salesQuery.watch().asyncExpand(
      (sales) => expenseQuery.watch().map(
        (expenses) => ReportSummary(
          sales: sales.fold(0, (sum, sale) => sum + sale.totalAmount),
          cost: sales.fold(0, (sum, sale) => sum + sale.totalCost),
          grossProfit: sales.fold(0, (sum, sale) => sum + sale.profit),
          expenses: expenses.fold(0, (sum, expense) => sum + expense.amount),
          orders: sales.length,
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
    final query = _database.select(_database.saleItems).join([
      innerJoin(
        _database.sales,
        _database.sales.id.equalsExp(_database.saleItems.saleId),
      ),
    ])..where(_database.sales.completedAt.isBetweenValues(from, until));
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
