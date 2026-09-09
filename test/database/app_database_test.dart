import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jm_pos/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test('creates the eleven-table schema and default settings', () async {
    final tables = await database
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'table' "
          "AND name NOT LIKE 'sqlite_%' ORDER BY name",
        )
        .get();

    expect(tables.map((row) => row.read<String>('name')), {
      'discount_products',
      'discounts',
      'expenses',
      'inventory_items',
      'inventory_movements',
      'product_inclusions',
      'products',
      'sale_items',
      'sale_reversals',
      'sales',
      'settings',
    });

    final settings = await database.select(database.settings).getSingle();
    expect(settings.businessName, 'BRADZ SILOGAN');
    expect(settings.receiptTagline, 'Savoring every bite');
    expect(
      settings.businessHours,
      'Mon-Tue 10:00 AM - 10:00 PM\n'
      'Wed - CLOSED\n'
      'Thu-Sun 10:00 AM - 10:00 PM',
    );
    expect(settings.businessAddress, 'BNCA Basak Lapu-Lapu City');
    expect(settings.currency, 'PHP');
    expect(settings.nextTransactionNumber, 1);
    expect(settings.printerPaperWidthMm, 58);
  });

  test(
    'permits negative stock but enforces one product per inventory item',
    () async {
      await database
          .into(database.inventoryItems)
          .insert(
            InventoryItemsCompanion.insert(
              id: 'inventory-1',
              name: 'Sisig Meal',
              stockQuantity: Value(-2),
              unit: 'serving',
              costPerUnit: 6500,
            ),
          );
      await database
          .into(database.products)
          .insert(
            ProductsCompanion.insert(
              id: 'product-1',
              name: 'Sisig Meal',
              sellingPrice: 12000,
              inventoryItemId: 'inventory-1',
            ),
          );

      final inventory = await database
          .select(database.inventoryItems)
          .getSingle();
      expect(inventory.stockQuantity, -2);

      await expectLater(
        database
            .into(database.products)
            .insert(
              ProductsCompanion.insert(
                id: 'product-2',
                name: 'Duplicate link',
                sellingPrice: 10000,
                inventoryItemId: 'inventory-1',
              ),
            ),
        throwsA(anything),
      );
    },
  );

  test('allows only one active discount', () async {
    await database
        .into(database.discounts)
        .insert(
          DiscountsCompanion.insert(
            id: 'discount-1',
            name: '10% off',
            percentageBasisPoints: 1000,
            scope: 'ALL',
            isActive: Value(true),
          ),
        );

    await expectLater(
      database
          .into(database.discounts)
          .insert(
            DiscountsCompanion.insert(
              id: 'discount-2',
              name: '20% off',
              percentageBasisPoints: 2000,
              scope: 'ALL',
              isActive: Value(true),
            ),
          ),
      throwsA(anything),
    );
  });

  test('validates cash received and calculated change', () async {
    final now = DateTime(2026, 9, 2, 12);

    await database
        .into(database.sales)
        .insert(
          SalesCompanion.insert(
            id: 'sale-1',
            transactionNumber: 1,
            subtotal: 24600,
            discountAmount: 0,
            totalAmount: 24600,
            totalCost: 15000,
            profit: 9600,
            profitMarginBasisPoints: 3902,
            paymentMethod: 'CASH',
            cashReceived: const Value(50000),
            changeAmount: const Value(25400),
            completedAt: now,
          ),
        );

    await expectLater(
      database
          .into(database.sales)
          .insert(
            SalesCompanion.insert(
              id: 'sale-2',
              transactionNumber: 2,
              subtotal: 24600,
              discountAmount: 0,
              totalAmount: 24600,
              totalCost: 15000,
              profit: 9600,
              profitMarginBasisPoints: 3902,
              paymentMethod: 'CASH',
              cashReceived: const Value(20000),
              changeAmount: const Value(-4600),
              completedAt: now,
            ),
          ),
      throwsA(anything),
    );
  });
}
