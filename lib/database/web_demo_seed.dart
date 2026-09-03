import 'package:flutter/foundation.dart';

import '../features/catalog/data/catalog_repository.dart';
import '../features/catalog/domain/catalog_item.dart';
import '../features/checkout/application/checkout_service.dart';
import '../features/discounts/data/discount_repository.dart';
import '../features/expenses/data/expense_repository.dart';
import '../features/pos/domain/cart.dart';
import '../features/settings/data/settings_repository.dart';
import 'app_database.dart';

Future<void> seedWebDemoData(AppDatabase database) async {
  if (!kIsWeb) return;
  if ((await database.select(database.products).get()).isNotEmpty) return;

  await SettingsRepository(database).updateBusiness(
    name: 'Mang Juan Silogan',
    footer: 'Salamat po! Balik kayo.',
  );

  final catalog = CatalogRepository(database);
  final products = <String, CatalogItem>{};
  for (final product in _products) {
    products[product.name] = await catalog.createProduct(
      name: product.name,
      sellingPrice: product.price,
      initialStock: product.stock,
      unit: product.unit,
      costPerUnit: product.cost,
      lowStockThreshold: product.threshold,
      category: product.category,
    );
  }

  final expenses = ExpenseRepository(database);
  final now = DateTime.now();
  await expenses.add(
    name: 'Shop Rent',
    category: 'Rent',
    amount: 1200000,
    date: now.subtract(const Duration(days: 2)),
    notes: 'Monthly stall rental',
  );
  await expenses.add(
    name: 'LPG Refill',
    category: 'Utilities',
    amount: 110000,
    date: now.subtract(const Duration(days: 1)),
    notes: 'Kitchen fuel',
  );
  await expenses.add(
    name: 'Packaging Supplies',
    category: 'Supplies',
    amount: 78500,
    date: now,
    notes: 'Cups and takeaway boxes',
  );

  await _sale(database, products, now.subtract(const Duration(hours: 7)), {
    'Tapsilog': 2,
    'Hot Coffee': 2,
  });
  await _sale(database, products, now.subtract(const Duration(hours: 4)), {
    'Longsilog': 1,
    'Extra Rice': 1,
  }, payment: 'GCASH');
  await DiscountRepository(database).activate(
    name: 'Senior/PWD',
    percentageBasisPoints: 2000,
    scope: 'ALL',
    productIds: const {},
  );
  await _sale(database, products, now.subtract(const Duration(hours: 1)), {
    'Bangsilog': 1,
    'Hot Coffee': 1,
  });
}

Future<void> _sale(
  AppDatabase database,
  Map<String, CatalogItem> products,
  DateTime completedAt,
  Map<String, int> quantities, {
  String payment = 'CASH',
}) async {
  final cart = quantities.entries
      .map(
        (entry) => CartLine(item: products[entry.key]!, quantity: entry.value),
      )
      .toList();
  final service = CheckoutService(database, now: () => completedAt);
  final quote = await service.quote(cart);
  await service.complete(
    cart: cart,
    paymentMethod: payment,
    paymentReference: payment == 'GCASH' ? 'GCASH-DEMO-829104' : null,
    cashReceived: payment == 'CASH' ? quote.totalAmount + 5000 : null,
  );
}

class _DemoProduct {
  const _DemoProduct(
    this.name,
    this.price,
    this.cost,
    this.stock,
    this.unit,
    this.threshold,
    this.category,
  );
  final String name;
  final int price;
  final int cost;
  final int stock;
  final String unit;
  final int threshold;
  final String category;
}

const _products = [
  _DemoProduct('Tapsilog', 14500, 6500, 24, 'serving', 6, 'Silog Meals'),
  _DemoProduct('Tocilog', 12500, 5800, 18, 'serving', 6, 'Silog Meals'),
  _DemoProduct('Bangsilog', 14000, 7200, 5, 'serving', 6, 'Silog Meals'),
  _DemoProduct('Longsilog', 12000, 5200, 14, 'serving', 6, 'Silog Meals'),
  _DemoProduct('Cornsilog', 11500, 5000, 0, 'serving', 5, 'Silog Meals'),
  _DemoProduct('Hotsilog', 9500, 4000, 19, 'serving', 6, 'Silog Meals'),
  _DemoProduct('Porksilog', 13500, 6800, 12, 'serving', 5, 'Silog Meals'),
  _DemoProduct('Extra Rice', 2500, 800, 42, 'serving', 10, 'Sides & Add-ons'),
  _DemoProduct('Fried Egg', 2000, 700, 35, 'piece', 10, 'Sides & Add-ons'),
  _DemoProduct('Hot Coffee', 3500, 1000, 28, 'cup', 8, 'Drinks'),
];
