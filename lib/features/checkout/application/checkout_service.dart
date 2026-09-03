import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../database/app_database.dart';
import '../../discounts/data/discount_repository.dart';
import '../../pos/domain/cart.dart';
import '../domain/sale_quote.dart';

class CheckoutResult {
  const CheckoutResult({required this.sale, required this.quote});

  final Sale sale;
  final SaleQuote quote;
}

class CheckoutService {
  CheckoutService(
    this._database, {
    String Function()? generateId,
    DateTime Function()? now,
  }) : _generateId = generateId ?? const Uuid().v4,
       _now = now ?? DateTime.now;

  final AppDatabase _database;
  final String Function() _generateId;
  final DateTime Function() _now;

  Future<SaleQuote> quote(List<CartLine> cart) async {
    if (cart.isEmpty) throw const ValidationException('Cart is empty.');
    final discount = await DiscountRepository(_database).getActive();
    final lines = <SaleLineQuote>[];
    for (final cartLine in cart) {
      if (cartLine.quantity <= 0) {
        throw const ValidationException(
          'Cart quantities must be greater than zero.',
        );
      }
      final product =
          await (_database.select(_database.products)
                ..where((table) => table.id.equals(cartLine.item.productId)))
              .getSingleOrNull();
      if (product == null || !product.isActive) {
        throw ValidationException(
          '${cartLine.item.name} is no longer available.',
        );
      }
      final inventory =
          await (_database.select(_database.inventoryItems)
                ..where((table) => table.id.equals(product.inventoryItemId)))
              .getSingle();
      final basisPoints = discount?.appliesTo(product.id) == true
          ? discount!.percentageBasisPoints
          : 0;
      final subtotal = product.sellingPrice * cartLine.quantity;
      final lineDiscount = roundDiscount(subtotal, basisPoints);
      lines.add(
        SaleLineQuote(
          productId: product.id,
          productName: product.name,
          quantity: cartLine.quantity,
          baseUnitPrice: product.sellingPrice,
          discountBasisPoints: basisPoints,
          lineSubtotal: subtotal,
          lineDiscount: lineDiscount,
          lineTotal: subtotal - lineDiscount,
          costPerUnit: inventory.costPerUnit,
          lineCost: inventory.costPerUnit * cartLine.quantity,
        ),
      );
    }
    return SaleQuote(lines: lines);
  }

  Future<CheckoutResult> complete({
    required List<CartLine> cart,
    required String paymentMethod,
    int? cashReceived,
    String? paymentReference,
  }) async {
    if (paymentMethod != 'CASH' && paymentMethod != 'GCASH') {
      throw const ValidationException('Select Cash or GCash.');
    }

    return _database.transaction(() async {
      final saleQuote = await quote(cart);
      if (paymentMethod == 'CASH' &&
          (cashReceived == null || cashReceived < saleQuote.totalAmount)) {
        throw const ValidationException('Cash received is insufficient.');
      }
      final settingsRow = await _database
          .select(_database.settings)
          .getSingle();
      final saleId = _generateId();
      final completedAt = _now();
      final tendered = paymentMethod == 'CASH' ? cashReceived : null;
      final change = paymentMethod == 'CASH'
          ? tendered! - saleQuote.totalAmount
          : null;

      await _database
          .into(_database.sales)
          .insert(
            SalesCompanion.insert(
              id: saleId,
              transactionNumber: settingsRow.nextTransactionNumber,
              subtotal: saleQuote.subtotal,
              discountAmount: saleQuote.discountAmount,
              totalAmount: saleQuote.totalAmount,
              totalCost: saleQuote.totalCost,
              profit: saleQuote.profit,
              profitMarginBasisPoints: saleQuote.profitMarginBasisPoints,
              paymentMethod: paymentMethod,
              paymentReference: Value(
                paymentReference?.trim().isEmpty == true
                    ? null
                    : paymentReference?.trim(),
              ),
              cashReceived: Value(tendered),
              changeAmount: Value(change),
              completedAt: completedAt,
            ),
          );

      for (final line in saleQuote.lines) {
        final product = await (_database.select(
          _database.products,
        )..where((table) => table.id.equals(line.productId))).getSingle();
        final inventory =
            await (_database.select(_database.inventoryItems)
                  ..where((table) => table.id.equals(product.inventoryItemId)))
                .getSingle();
        final quantityAfter = inventory.stockQuantity - line.quantity;
        await _database
            .into(_database.saleItems)
            .insert(
              SaleItemsCompanion.insert(
                id: _generateId(),
                saleId: saleId,
                productId: line.productId,
                productName: line.productName,
                quantity: line.quantity,
                baseUnitPrice: line.baseUnitPrice,
                discountBasisPoints: line.discountBasisPoints,
                actualUnitPrice: line.actualUnitPrice,
                lineSubtotal: line.lineSubtotal,
                lineDiscount: line.lineDiscount,
                lineTotal: line.lineTotal,
                costPerUnit: line.costPerUnit,
                lineCost: line.lineCost,
                lineProfit: line.lineProfit,
              ),
            );
        await (_database.update(
          _database.inventoryItems,
        )..where((table) => table.id.equals(inventory.id))).write(
          InventoryItemsCompanion(
            stockQuantity: Value(quantityAfter),
            updatedAt: Value(completedAt),
          ),
        );
        await _database
            .into(_database.inventoryMovements)
            .insert(
              InventoryMovementsCompanion.insert(
                id: _generateId(),
                inventoryItemId: inventory.id,
                movementType: 'SALE',
                quantity: -line.quantity,
                quantityBefore: inventory.stockQuantity,
                quantityAfter: quantityAfter,
                referenceType: const Value('SALE'),
                referenceId: Value(saleId),
              ),
            );
      }
      await (_database.update(
        _database.settings,
      )..where((table) => table.id.equals(1))).write(
        SettingsCompanion(
          nextTransactionNumber: Value(settingsRow.nextTransactionNumber + 1),
          updatedAt: Value(completedAt),
        ),
      );
      final sale = await (_database.select(
        _database.sales,
      )..where((table) => table.id.equals(saleId))).getSingle();
      return CheckoutResult(sale: sale, quote: saleQuote);
    });
  }
}
