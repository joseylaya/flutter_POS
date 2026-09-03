import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../catalog/domain/catalog_item.dart';
import '../domain/cart.dart';

class CartController extends StateNotifier<CartState> {
  CartController() : super(const CartState());

  void add(CatalogItem item) {
    final index = state.lines.indexWhere(
      (line) => line.item.productId == item.productId,
    );
    if (index == -1) {
      state = CartState(
        lines: [
          ...state.lines,
          CartLine(item: item, quantity: 1),
        ],
      );
      return;
    }
    setQuantity(item.productId, state.lines[index].quantity + 1);
  }

  void decrement(CatalogItem item) {
    final index = state.lines.indexWhere(
      (line) => line.item.productId == item.productId,
    );
    if (index == -1) return;
    setQuantity(item.productId, state.lines[index].quantity - 1);
  }

  void setQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    state = CartState(
      lines: [
        for (final line in state.lines)
          if (line.item.productId == productId)
            line.copyWith(quantity: quantity)
          else
            line,
      ],
    );
  }

  void remove(String productId) {
    state = CartState(
      lines: state.lines
          .where((line) => line.item.productId != productId)
          .toList(),
    );
  }

  void clear() => state = const CartState();
}

final cartProvider = StateNotifierProvider<CartController, CartState>((ref) {
  return CartController();
});
