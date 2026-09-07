import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jm_pos/core/errors/validation_exception.dart';
import 'package:jm_pos/database/app_database.dart';
import 'package:jm_pos/features/catalog/data/catalog_repository.dart';

void main() {
  late AppDatabase database;
  late CatalogRepository repository;
  late int nextId;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    nextId = 1;
    repository = CatalogRepository(
      database,
      generateId: () => 'id-${nextId++}',
    );
  });

  tearDown(() => database.close());

  test(
    'creates linked product and inventory with an initial movement',
    () async {
      final item = await repository.createProduct(
        name: '  Sisig Meal ',
        sellingPrice: 12000,
        initialStock: 10,
        unit: ' serving ',
        costPerUnit: 6500,
        lowStockThreshold: 5,
      );

      expect(item.name, 'Sisig Meal');
      expect(item.unit, 'serving');
      expect(item.stockQuantity, 10);

      final product = await database.select(database.products).getSingle();
      final inventory = await database
          .select(database.inventoryItems)
          .getSingle();
      final movement = await database
          .select(database.inventoryMovements)
          .getSingle();
      expect(product.inventoryItemId, inventory.id);
      expect(inventory.stockQuantity, 10);
      expect(movement.movementType, 'ADD');
      expect(movement.quantityBefore, 0);
      expect(movement.quantityAfter, 10);
      expect(movement.referenceType, 'INITIAL_STOCK');
    },
  );

  test(
    'manual removal can take inventory below zero and is traceable',
    () async {
      final item = await repository.createProduct(
        name: 'Coke',
        sellingPrice: 3000,
        initialStock: 1,
        unit: 'bottle',
        costPerUnit: 2000,
        lowStockThreshold: 3,
      );

      final quantityAfter = await repository.removeStock(
        item.inventoryItemId,
        3,
      );
      expect(quantityAfter, -2);

      final inventory = await database
          .select(database.inventoryItems)
          .getSingle();
      final movements = await database
          .select(database.inventoryMovements)
          .get();
      expect(inventory.stockQuantity, -2);
      expect(movements.last.movementType, 'REMOVE');
      expect(movements.last.quantity, -3);
      expect(movements.last.quantityBefore, 1);
      expect(movements.last.quantityAfter, -2);
    },
  );

  test('updates product and linked inventory together', () async {
    final item = await repository.createProduct(
      name: 'Coke',
      sellingPrice: 3000,
      initialStock: 2,
      unit: 'bottle',
      costPerUnit: 2000,
      lowStockThreshold: 3,
    );

    await repository.updateProduct(
      productId: item.productId,
      name: 'Coke Zero',
      sellingPrice: 3500,
      unit: 'can',
      costPerUnit: 2200,
      lowStockThreshold: 4,
    );

    final product = await database.select(database.products).getSingle();
    final inventory = await database
        .select(database.inventoryItems)
        .getSingle();
    expect(product.name, 'Coke Zero');
    expect(product.sellingPrice, 3500);
    expect(inventory.name, 'Coke Zero');
    expect(inventory.unit, 'can');
    expect(inventory.costPerUnit, 2200);
    expect(inventory.stockQuantity, 2);
  });

  test('stores inclusions only for existing active inventory items', () async {
    final egg = await repository.createProduct(
      name: 'Egg',
      sellingPrice: 1500,
      initialStock: 0,
      unit: 'piece',
      costPerUnit: 700,
      lowStockThreshold: 4,
    );
    final meal = await repository.createProduct(
      name: 'Sisig Silog',
      sellingPrice: 12000,
      initialStock: 5,
      unit: 'meal',
      costPerUnit: 5000,
      lowStockThreshold: 2,
      inclusions: [
        ProductInclusionInput(
          inventoryItemId: egg.inventoryItemId,
          quantity: 1,
        ),
      ],
    );

    final inclusions = await repository.getProductInclusions(meal.productId);
    expect(inclusions, hasLength(1));
    expect(inclusions.single.inventoryItemId, egg.inventoryItemId);
    expect(inclusions.single.quantity, 1);

    await expectLater(
      repository.updateProduct(
        productId: meal.productId,
        name: meal.name,
        sellingPrice: meal.sellingPrice,
        unit: meal.unit,
        costPerUnit: meal.costPerUnit,
        lowStockThreshold: meal.lowStockThreshold,
        inclusions: const [
          ProductInclusionInput(
            inventoryItemId: 'missing-inventory',
            quantity: 1,
          ),
        ],
      ),
      throwsA(isA<ValidationException>()),
    );
    expect(await repository.getProductInclusions(meal.productId), hasLength(1));

    await expectLater(
      repository.setActive(egg.productId, isActive: false),
      throwsA(
        isA<ValidationException>().having(
          (error) => error.message,
          'message',
          contains('included in Sisig Silog'),
        ),
      ),
    );
  });

  test('deactivation hides a product without deleting it', () async {
    final item = await repository.createProduct(
      name: 'Longsilog',
      sellingPrice: 11000,
      initialStock: 5,
      unit: 'serving',
      costPerUnit: 6000,
      lowStockThreshold: 2,
    );

    await repository.setActive(item.productId, isActive: false);

    expect(await repository.watchCatalog().first, isEmpty);
    final allItems = await repository.watchCatalog(activeOnly: false).first;
    expect(allItems, hasLength(1));
    expect(allItems.single.isActive, isFalse);
    expect(await database.select(database.products).get(), hasLength(1));
  });

  test('rejects invalid values before writing', () async {
    expect(
      () => repository.createProduct(
        name: ' ',
        sellingPrice: -1,
        initialStock: -1,
        unit: '',
        costPerUnit: -1,
        lowStockThreshold: -1,
      ),
      throwsA(isA<ValidationException>()),
    );

    expect(await database.select(database.products).get(), isEmpty);
    expect(await database.select(database.inventoryItems).get(), isEmpty);
  });
}
