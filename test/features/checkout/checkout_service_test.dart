import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jm_pos/core/errors/validation_exception.dart';
import 'package:jm_pos/database/app_database.dart';
import 'package:jm_pos/features/catalog/data/catalog_repository.dart';
import 'package:jm_pos/features/checkout/application/checkout_service.dart';
import 'package:jm_pos/features/checkout/domain/sale_quote.dart';
import 'package:jm_pos/features/discounts/data/discount_repository.dart';
import 'package:jm_pos/features/pos/domain/cart.dart';
import 'package:jm_pos/features/printing/receipt_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase database;
  late CatalogRepository catalog;
  late DiscountRepository discounts;
  late CheckoutService checkout;
  var catalogId = 0;
  var discountId = 0;
  var checkoutId = 0;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    catalog = CatalogRepository(
      database,
      generateId: () => 'catalog-${catalogId++}',
    );
    discounts = DiscountRepository(
      database,
      generateId: () => 'discount-${discountId++}',
    );
    checkout = CheckoutService(
      database,
      generateId: () => 'checkout-${checkoutId++}',
      now: () => DateTime(2026, 9, 2, 12),
    );
  });

  tearDown(() => database.close());

  test('rounds percentage discount once at line level using half-up', () {
    expect(roundDiscount(101, 500), 5);
    expect(roundDiscount(110, 500), 6);
    expect(roundDiscount(24000, 1000), 2400);
  });

  test(
    'completes discounted cash sale atomically using historical snapshots',
    () async {
      final sisig = await catalog.createProduct(
        name: 'Sisig Meal',
        sellingPrice: 12000,
        initialStock: 10,
        unit: 'serving',
        costPerUnit: 6500,
        lowStockThreshold: 5,
      );
      final coke = await catalog.createProduct(
        name: 'Coke',
        sellingPrice: 3000,
        initialStock: 20,
        unit: 'bottle',
        costPerUnit: 2000,
        lowStockThreshold: 5,
      );
      await discounts.activate(
        name: '10% off Sisig',
        percentageBasisPoints: 1000,
        scope: 'SELECTED',
        productIds: {sisig.productId},
      );

      final result = await checkout.complete(
        cart: [
          CartLine(item: sisig, quantity: 2),
          CartLine(item: coke, quantity: 1),
        ],
        paymentMethod: 'CASH',
        cashReceived: 50000,
      );

      expect(result.quote.subtotal, 27000);
      expect(result.quote.discountAmount, 2400);
      expect(result.quote.totalAmount, 24600);
      expect(result.quote.totalCost, 15000);
      expect(result.quote.profit, 9600);
      expect(result.quote.profitMarginBasisPoints, 3902);
      expect(result.sale.transactionNumber, 1);
      expect(result.sale.changeAmount, 25400);

      final inventory = await database.select(database.inventoryItems).get();
      expect(inventory.map((item) => item.stockQuantity), containsAll([8, 19]));
      final saleItems = await database.select(database.saleItems).get();
      expect(saleItems, hasLength(2));
      expect(
        saleItems
            .firstWhere((item) => item.productId == sisig.productId)
            .lineTotal,
        21600,
      );
      final saleMovements = await (database.select(
        database.inventoryMovements,
      )..where((table) => table.movementType.equals('SALE'))).get();
      expect(saleMovements, hasLength(2));
      expect(
        (await database.select(database.settings).getSingle())
            .nextTransactionNumber,
        2,
      );
      final receipt = await ReceiptService().buildReceiptBytes(
        settings: await database.select(database.settings).getSingle(),
        sale: result.sale,
        items: saleItems,
      );
      final receiptText = String.fromCharCodes(receipt);
      expect(receipt, isNotEmpty);
      expect(receiptText, contains('Sisig Meal'));
      expect(receiptText, contains('Transaction #000001'));
    },
  );

  test(
    'allows sale to take stock negative and increments transaction numbers',
    () async {
      final product = await catalog.createProduct(
        name: 'Longsilog',
        sellingPrice: 10000,
        initialStock: 1,
        unit: 'serving',
        costPerUnit: 5000,
        lowStockThreshold: 2,
      );
      final cart = [CartLine(item: product, quantity: 2)];
      final first = await checkout.complete(cart: cart, paymentMethod: 'GCASH');
      final second = await checkout.complete(
        cart: cart,
        paymentMethod: 'GCASH',
      );

      expect(first.sale.transactionNumber, 1);
      expect(second.sale.transactionNumber, 2);
      expect(
        (await database.select(database.inventoryItems).getSingle())
            .stockQuantity,
        -3,
      );
    },
  );

  test('insufficient cash rolls back sale, inventory, and sequence', () async {
    final product = await catalog.createProduct(
      name: 'Tapsilog',
      sellingPrice: 12000,
      initialStock: 5,
      unit: 'serving',
      costPerUnit: 7000,
      lowStockThreshold: 2,
    );

    await expectLater(
      checkout.complete(
        cart: [CartLine(item: product, quantity: 1)],
        paymentMethod: 'CASH',
        cashReceived: 10000,
      ),
      throwsA(isA<ValidationException>()),
    );

    expect(await database.select(database.sales).get(), isEmpty);
    expect(
      (await database.select(database.inventoryItems).getSingle())
          .stockQuantity,
      5,
    );
    expect(
      (await database.select(database.settings).getSingle())
          .nextTransactionNumber,
      1,
    );
  });
}
