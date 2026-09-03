import 'dart:typed_data';

class CatalogItem {
  const CatalogItem({
    required this.productId,
    required this.inventoryItemId,
    required this.name,
    this.category = 'Other',
    required this.sellingPrice,
    required this.stockQuantity,
    required this.unit,
    required this.costPerUnit,
    required this.lowStockThreshold,
    required this.isActive,
    this.imageData,
  });

  final String productId;
  final String inventoryItemId;
  final String name;
  final String category;
  final int sellingPrice;
  final int stockQuantity;
  final String unit;
  final int costPerUnit;
  final int lowStockThreshold;
  final bool isActive;
  final Uint8List? imageData;

  bool get isNegativeStock => stockQuantity < 0;
  bool get isLowStock => stockQuantity <= lowStockThreshold;
}
