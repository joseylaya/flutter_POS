import 'package:flutter_test/flutter_test.dart';
import 'package:jm_pos/features/catalog/domain/catalog_item.dart';
import 'package:jm_pos/features/pos/application/cart_controller.dart';

void main() {
  const item = CatalogItem(
    productId: 'product-1',
    inventoryItemId: 'inventory-1',
    name: 'Tapsilog',
    category: 'Silog Meals',
    sellingPrice: 14500,
    stockQuantity: 10,
    unit: 'serving',
    costPerUnit: 6500,
    lowStockThreshold: 2,
    isActive: true,
  );

  test('add, decrement, set quantity, remove, and clear are consistent', () {
    final controller = CartController();

    controller.add(item);
    controller.add(item);
    expect(controller.state.itemCount, 2);
    expect(controller.state.lines.single.quantity, 2);

    controller.decrement(item);
    expect(controller.state.lines.single.quantity, 1);

    controller.setQuantity(item.productId, 5);
    expect(controller.state.itemCount, 5);

    controller.decrement(item);
    expect(controller.state.lines.single.quantity, 4);

    controller.remove(item.productId);
    expect(controller.state.isEmpty, isTrue);

    controller.add(item);
    controller.clear();
    expect(controller.state.isEmpty, isTrue);
  });

  test('zero and negative quantities remove the line safely', () {
    final controller = CartController()..add(item);

    controller.setQuantity(item.productId, 0);
    expect(controller.state.isEmpty, isTrue);

    controller.add(item);
    controller.setQuantity(item.productId, -10);
    expect(controller.state.isEmpty, isTrue);
  });
}
