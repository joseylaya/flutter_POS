import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../database/app_database.dart';
import '../domain/active_discount.dart';

class DiscountRepository {
  DiscountRepository(this._database, {String Function()? generateId})
    : _generateId = generateId ?? const Uuid().v4;

  final AppDatabase _database;
  final String Function() _generateId;

  Stream<ActiveDiscount?> watchActive() {
    final query = _database.select(_database.discounts)
      ..where((table) => table.isActive.equals(true));
    return query.watchSingleOrNull().asyncMap(_withProducts);
  }

  Future<ActiveDiscount?> getActive() async {
    final discount = await (_database.select(
      _database.discounts,
    )..where((table) => table.isActive.equals(true))).getSingleOrNull();
    return _withProducts(discount);
  }

  Future<void> activate({
    required String name,
    required int percentageBasisPoints,
    required String scope,
    Set<String> productIds = const {},
  }) async {
    if (percentageBasisPoints < 1 || percentageBasisPoints > 10000) {
      throw const ValidationException(
        'Discount must be greater than 0% and no more than 100%.',
      );
    }
    if (scope != 'ALL' && scope != 'SELECTED') {
      throw const ValidationException(
        'Discount scope must be ALL or SELECTED.',
      );
    }
    if (scope == 'SELECTED' && productIds.isEmpty) {
      throw const ValidationException('Select at least one product.');
    }
    final id = _generateId();
    await _database.transaction(() async {
      await (_database.update(_database.discounts)
            ..where((table) => table.isActive.equals(true)))
          .write(const DiscountsCompanion(isActive: Value(false)));
      await _database
          .into(_database.discounts)
          .insert(
            DiscountsCompanion.insert(
              id: id,
              name: name.trim().isEmpty ? 'Discount' : name.trim(),
              percentageBasisPoints: percentageBasisPoints,
              scope: scope,
              isActive: const Value(true),
            ),
          );
      if (scope == 'SELECTED') {
        for (final productId in productIds) {
          await _database
              .into(_database.discountProducts)
              .insert(
                DiscountProductsCompanion.insert(
                  id: _generateId(),
                  discountId: id,
                  productId: productId,
                ),
              );
        }
      }
    });
  }

  Future<void> disable() async {
    await (_database.update(_database.discounts)
          ..where((table) => table.isActive.equals(true)))
        .write(const DiscountsCompanion(isActive: Value(false)));
  }

  Future<ActiveDiscount?> _withProducts(Discount? discount) async {
    if (discount == null) return null;
    final links = await (_database.select(
      _database.discountProducts,
    )..where((table) => table.discountId.equals(discount.id))).get();
    return ActiveDiscount(
      id: discount.id,
      name: discount.name,
      percentageBasisPoints: discount.percentageBasisPoints,
      scope: discount.scope,
      productIds: links.map((link) => link.productId).toSet(),
    );
  }
}
