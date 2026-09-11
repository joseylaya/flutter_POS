import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jm_pos/database/app_database.dart';
import 'package:jm_pos/features/catalog/data/catalog_repository.dart';
import 'package:jm_pos/features/checkout/application/checkout_service.dart';
import 'package:jm_pos/features/expenses/data/expense_repository.dart';
import 'package:jm_pos/features/pos/domain/cart.dart';
import 'package:jm_pos/features/reports/data/reports_repository.dart';

void main() {
  test(
    'reports sales, gross profit, expenses, and net profit separately',
    () async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);
      var id = 0;
      String nextId() => 'id-${id++}';
      final catalog = CatalogRepository(database, generateId: nextId);
      final product = await catalog.createProduct(
        name: 'Sisig',
        sellingPrice: 12000,
        initialStock: 5,
        unit: 'serving',
        costPerUnit: 6500,
        lowStockThreshold: 2,
      );
      await CheckoutService(
        database,
        generateId: nextId,
        now: () => DateTime(2026, 9, 2, 12),
      ).complete(
        cart: [CartLine(item: product, quantity: 2)],
        paymentMethod: 'GCASH',
        paymentReference: 'REF-REPORT',
      );
      await ExpenseRepository(database, generateId: nextId).add(
        name: 'Electricity',
        category: 'Utilities',
        amount: 1000,
        date: DateTime(2026, 9, 2, 14),
      );

      final summary = await ReportsRepository(
        database,
      ).watchSummary(DateTime(2026, 9, 2), DateTime(2026, 9, 3)).first;
      expect(summary.sales, 24000);
      expect(summary.cost, 13000);
      expect(summary.grossProfit, 11000);
      expect(summary.expenses, 1000);
      expect(summary.netProfit, 10000);
      expect(summary.orders, 1);
      expect(summary.itemsSold, 2);

      final sale = (await database.select(database.sales).get()).single;
      await (database.update(
        database.sales,
      )..where((table) => table.id.equals(sale.id))).write(
        const SalesCompanion(
          subtotal: Value(106500),
          discountAmount: Value(0),
          totalAmount: Value(106500),
          profit: Value(93500),
          profitMarginBasisPoints: Value(8779),
        ),
      );
      final reconciledSummary = await ReportsRepository(
        database,
      ).watchSummary(DateTime(2026, 9, 2), DateTime(2026, 9, 3)).first;
      final performance = await ReportsRepository(database)
          .watchProductPerformance(DateTime(2026, 9, 2), DateTime(2026, 9, 3))
          .first;
      expect(
        performance.fold<int>(0, (sum, item) => sum + item.revenue),
        reconciledSummary.sales,
      );
      expect(
        performance.fold<int>(0, (sum, item) => sum + item.quantity),
        reconciledSummary.itemsSold,
      );
      expect(
        performance.fold<int>(0, (sum, item) => sum + item.profit),
        reconciledSummary.grossProfit,
      );

      await ReportsRepository(database, generateId: nextId).reverseSale(
        saleId: sale.id,
        reversalType: 'REFUND',
        reason: 'Customer returned the order',
      );
      final reversedSummary = await ReportsRepository(
        database,
      ).watchSummary(DateTime(2026, 9, 2), DateTime(2026, 9, 3)).first;
      expect(reversedSummary.sales, 0);
      expect(reversedSummary.cost, 0);
      expect(reversedSummary.grossProfit, 0);
      expect(reversedSummary.orders, 0);
      expect(reversedSummary.expenses, 1000);
      expect(reversedSummary.netProfit, -1000);
      expect(
        (await database.select(database.inventoryItems).getSingle())
            .stockQuantity,
        5,
      );

      await expectLater(
        ReportsRepository(database, generateId: nextId).reverseSale(
          saleId: sale.id,
          reversalType: 'REFUND',
          reason: 'Duplicate refund attempt',
        ),
        throwsA(isA<Exception>()),
      );
      expect(
        (await database.select(database.inventoryItems).getSingle())
            .stockQuantity,
        5,
      );
    },
  );
}
