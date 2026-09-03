import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../core/errors/validation_exception.dart';
import '../../../database/app_database.dart';
import '../domain/catalog_item.dart';

typedef IdGenerator = String Function();

class CatalogRepository {
  CatalogRepository(this._database, {IdGenerator? generateId})
    : _generateId = generateId ?? const Uuid().v4;

  final AppDatabase _database;
  final IdGenerator _generateId;

  Stream<List<CatalogItem>> watchCatalog({bool activeOnly = true}) {
    final query = _database.select(_database.products).join([
      innerJoin(
        _database.inventoryItems,
        _database.inventoryItems.id.equalsExp(
          _database.products.inventoryItemId,
        ),
      ),
    ]);
    if (activeOnly) {
      query.where(
        _database.products.isActive.equals(true) &
            _database.inventoryItems.isActive.equals(true),
      );
    }
    query.orderBy([OrderingTerm.asc(_database.products.name)]);

    return query.watch().map(
      (rows) => rows
          .map((row) {
            final product = row.readTable(_database.products);
            final inventory = row.readTable(_database.inventoryItems);
            return CatalogItem(
              productId: product.id,
              inventoryItemId: inventory.id,
              name: product.name,
              category: product.category,
              sellingPrice: product.sellingPrice,
              stockQuantity: inventory.stockQuantity,
              unit: inventory.unit,
              costPerUnit: inventory.costPerUnit,
              lowStockThreshold: inventory.lowStockThreshold,
              isActive: product.isActive && inventory.isActive,
              imageData: product.imageData,
            );
          })
          .toList(growable: false),
    );
  }

  Future<CatalogItem> createProduct({
    required String name,
    required int sellingPrice,
    required int initialStock,
    required String unit,
    required int costPerUnit,
    required int lowStockThreshold,
    String category = 'Other',
    Uint8List? imageData,
  }) async {
    final cleanName = name.trim();
    final cleanUnit = unit.trim();
    final cleanCategory = category.trim().isEmpty ? 'Other' : category.trim();
    _validateCatalogValues(
      name: cleanName,
      sellingPrice: sellingPrice,
      unit: cleanUnit,
      costPerUnit: costPerUnit,
      lowStockThreshold: lowStockThreshold,
    );
    if (initialStock < 0) {
      throw const ValidationException('Initial stock cannot be negative.');
    }

    final productId = _generateId();
    final inventoryItemId = _generateId();
    final movementId = initialStock == 0 ? null : _generateId();

    await _database.transaction(() async {
      await _database
          .into(_database.inventoryItems)
          .insert(
            InventoryItemsCompanion.insert(
              id: inventoryItemId,
              name: cleanName,
              unit: cleanUnit,
              costPerUnit: costPerUnit,
              lowStockThreshold: Value(lowStockThreshold),
            ),
          );
      await _database
          .into(_database.products)
          .insert(
            ProductsCompanion.insert(
              id: productId,
              name: cleanName,
              category: Value(cleanCategory),
              sellingPrice: sellingPrice,
              inventoryItemId: inventoryItemId,
              imageData: Value(imageData),
            ),
          );
      if (movementId != null) {
        await _database
            .into(_database.inventoryMovements)
            .insert(
              InventoryMovementsCompanion.insert(
                id: movementId,
                inventoryItemId: inventoryItemId,
                movementType: 'ADD',
                quantity: initialStock,
                quantityBefore: 0,
                quantityAfter: initialStock,
                referenceType: const Value('INITIAL_STOCK'),
                referenceId: Value(productId),
              ),
            );
        await (_database.update(_database.inventoryItems)
              ..where((table) => table.id.equals(inventoryItemId)))
            .write(InventoryItemsCompanion(stockQuantity: Value(initialStock)));
      }
    });

    return CatalogItem(
      productId: productId,
      inventoryItemId: inventoryItemId,
      name: cleanName,
      category: cleanCategory,
      sellingPrice: sellingPrice,
      stockQuantity: initialStock,
      unit: cleanUnit,
      costPerUnit: costPerUnit,
      lowStockThreshold: lowStockThreshold,
      isActive: true,
      imageData: imageData,
    );
  }

  Future<void> updateProduct({
    required String productId,
    required String name,
    required int sellingPrice,
    required String unit,
    required int costPerUnit,
    required int lowStockThreshold,
    String? category,
    Uint8List? imageData,
  }) async {
    final cleanName = name.trim();
    final cleanUnit = unit.trim();
    _validateCatalogValues(
      name: cleanName,
      sellingPrice: sellingPrice,
      unit: cleanUnit,
      costPerUnit: costPerUnit,
      lowStockThreshold: lowStockThreshold,
    );

    await _database.transaction(() async {
      final product = await (_database.select(
        _database.products,
      )..where((table) => table.id.equals(productId))).getSingleOrNull();
      if (product == null) {
        throw const ValidationException('Product does not exist.');
      }
      final now = DateTime.now();
      final cleanCategory = category == null || category.trim().isEmpty
          ? product.category
          : category.trim();
      await (_database.update(
        _database.products,
      )..where((table) => table.id.equals(productId))).write(
        ProductsCompanion(
          name: Value(cleanName),
          category: Value(cleanCategory),
          sellingPrice: Value(sellingPrice),
          imageData: Value(imageData),
          updatedAt: Value(now),
        ),
      );
      await (_database.update(
        _database.inventoryItems,
      )..where((table) => table.id.equals(product.inventoryItemId))).write(
        InventoryItemsCompanion(
          name: Value(cleanName),
          unit: Value(cleanUnit),
          costPerUnit: Value(costPerUnit),
          lowStockThreshold: Value(lowStockThreshold),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<int> addStock(String inventoryItemId, int quantity) =>
      _adjustStock(inventoryItemId, quantity, 'ADD');

  Future<int> removeStock(String inventoryItemId, int quantity) =>
      _adjustStock(inventoryItemId, -quantity, 'REMOVE');

  Future<void> setActive(String productId, {required bool isActive}) async {
    await _database.transaction(() async {
      final product = await (_database.select(
        _database.products,
      )..where((table) => table.id.equals(productId))).getSingleOrNull();
      if (product == null) {
        throw const ValidationException('Product does not exist.');
      }
      final now = DateTime.now();
      await (_database.update(
        _database.products,
      )..where((table) => table.id.equals(productId))).write(
        ProductsCompanion(isActive: Value(isActive), updatedAt: Value(now)),
      );
      await (_database.update(
        _database.inventoryItems,
      )..where((table) => table.id.equals(product.inventoryItemId))).write(
        InventoryItemsCompanion(
          isActive: Value(isActive),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<int> _adjustStock(
    String inventoryItemId,
    int signedQuantity,
    String movementType,
  ) async {
    if (signedQuantity == 0 ||
        (movementType == 'ADD' && signedQuantity < 0) ||
        (movementType == 'REMOVE' && signedQuantity > 0)) {
      throw const ValidationException(
        'Stock quantity must be greater than zero.',
      );
    }

    return _database.transaction(() async {
      final item = await (_database.select(
        _database.inventoryItems,
      )..where((table) => table.id.equals(inventoryItemId))).getSingleOrNull();
      if (item == null) {
        throw const ValidationException('Inventory item does not exist.');
      }
      final quantityAfter = item.stockQuantity + signedQuantity;
      final now = DateTime.now();
      await (_database.update(
        _database.inventoryItems,
      )..where((table) => table.id.equals(inventoryItemId))).write(
        InventoryItemsCompanion(
          stockQuantity: Value(quantityAfter),
          updatedAt: Value(now),
        ),
      );
      await _database
          .into(_database.inventoryMovements)
          .insert(
            InventoryMovementsCompanion.insert(
              id: _generateId(),
              inventoryItemId: inventoryItemId,
              movementType: movementType,
              quantity: signedQuantity,
              quantityBefore: item.stockQuantity,
              quantityAfter: quantityAfter,
              referenceType: const Value('MANUAL_ADJUSTMENT'),
            ),
          );
      return quantityAfter;
    });
  }

  void _validateCatalogValues({
    required String name,
    required int sellingPrice,
    required String unit,
    required int costPerUnit,
    required int lowStockThreshold,
  }) {
    if (name.isEmpty) {
      throw const ValidationException('Product name is required.');
    }
    if (unit.isEmpty) {
      throw const ValidationException('Inventory unit is required.');
    }
    if (sellingPrice < 0 || costPerUnit < 0 || lowStockThreshold < 0) {
      throw const ValidationException(
        'Price, cost, and threshold cannot be negative.',
      );
    }
  }
}
