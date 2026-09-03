import '../../catalog/domain/catalog_item.dart';

class CartLine {
  const CartLine({required this.item, required this.quantity});

  final CatalogItem item;
  final int quantity;

  CartLine copyWith({int? quantity}) =>
      CartLine(item: item, quantity: quantity ?? this.quantity);
}

class CartState {
  const CartState({this.lines = const []});

  final List<CartLine> lines;

  bool get isEmpty => lines.isEmpty;
  int get itemCount => lines.fold(0, (sum, line) => sum + line.quantity);
}
