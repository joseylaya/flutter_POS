import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:jm_pos/app/app.dart';
import 'package:jm_pos/features/catalog/application/catalog_providers.dart';
import 'package:jm_pos/features/catalog/domain/catalog_item.dart';
import 'package:jm_pos/features/discounts/application/discount_providers.dart';
import 'package:jm_pos/features/discounts/domain/active_discount.dart';

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
}
