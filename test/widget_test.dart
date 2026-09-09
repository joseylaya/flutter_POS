import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:jm_pos/app/app.dart';
import 'package:jm_pos/features/catalog/application/catalog_providers.dart';
import 'package:jm_pos/features/catalog/domain/catalog_item.dart';
import 'package:jm_pos/features/discounts/application/discount_providers.dart';
import 'package:jm_pos/features/discounts/domain/active_discount.dart';
import 'package:jm_pos/features/pos/application/cart_controller.dart';
import 'package:jm_pos/features/pos/presentation/pos_screen.dart';

void main() {
  testWidgets('shows catalog navigation and opens the product form', (
    tester,
  ) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('com.jmpos.jm_pos/activation'),
          (call) async => {
            'activated': true,
            'installationId': 'TEST-DEVICE',
            'requestPin': '123456',
            'businessName': 'Test Store',
          },
        );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeCatalogProvider.overrideWith(
            (ref) => Stream.value(const <CatalogItem>[]),
          ),
          activeDiscountProvider.overrideWith(
            (ref) => Stream.value(null as ActiveDiscount?),
          ),
        ],
        child: const JmPosApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Point of Sale'), findsOneWidget);
    expect(find.text('Inventory'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.restaurant_menu));
    await tester.pumpAndSettle();
    expect(find.text('No products yet'), findsOneWidget);

    await tester.tap(find.byKey(const Key('add-product-button')));
    await tester.pumpAndSettle();

    expect(find.text('Add product'), findsWidgets);
    expect(find.text('Product name'), findsOneWidget);
    expect(find.text('Selling price'), findsOneWidget);
    expect(find.text('Initial stock'), findsOneWidget);
  });

  testWidgets('mobile current-order stepper adds and removes repeatedly', (
    tester,
  ) async {
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
    final cart = CartController()..add(item);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeCatalogProvider.overrideWith(
            (ref) => Stream.value(const [item]),
          ),
          activeDiscountProvider.overrideWith(
            (ref) => Stream.value(null as ActiveDiscount?),
          ),
          cartProvider.overrideWith((ref) => cart),
        ],
        child: const MaterialApp(home: PosScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1 items'), findsOneWidget);

    await tester.tap(find.text('1 items'));
    await tester.pumpAndSettle();
    expect(find.text('Current Order'), findsOneWidget);

    await tester.tap(find.byKey(const Key('increase-product-1')));
    await tester.pumpAndSettle();
    expect(cart.state.itemCount, 2);
    await tester.tap(find.byKey(const Key('increase-product-1')));
    await tester.pumpAndSettle();
    expect(cart.state.itemCount, 3);

    await tester.tap(find.byKey(const Key('decrease-product-1')));
    await tester.pumpAndSettle();
    expect(cart.state.itemCount, 2);
  });
}
