class SaleLineQuote {
  const SaleLineQuote({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.baseUnitPrice,
    required this.discountBasisPoints,
    required this.lineSubtotal,
    required this.lineDiscount,
    required this.lineTotal,
    required this.costPerUnit,
    required this.lineCost,
  });

  final String productId;
  final String productName;
  final int quantity;
  final int baseUnitPrice;
  final int discountBasisPoints;
  final int lineSubtotal;
  final int lineDiscount;
  final int lineTotal;
  final int costPerUnit;
  final int lineCost;

  int get lineProfit => lineTotal - lineCost;
  int get actualUnitPrice => (lineTotal + quantity ~/ 2) ~/ quantity;
}

class SaleQuote {
  const SaleQuote({required this.lines});

  final List<SaleLineQuote> lines;

  int get subtotal => lines.fold(0, (sum, line) => sum + line.lineSubtotal);
  int get discountAmount =>
      lines.fold(0, (sum, line) => sum + line.lineDiscount);
  int get totalAmount => lines.fold(0, (sum, line) => sum + line.lineTotal);
  int get totalCost => lines.fold(0, (sum, line) => sum + line.lineCost);
  int get profit => totalAmount - totalCost;
  int get profitMarginBasisPoints =>
      totalAmount == 0 ? 0 : _roundHalfUp(profit * 10000, totalAmount);
}

int roundDiscount(int lineSubtotal, int percentageBasisPoints) {
  return _roundHalfUp(lineSubtotal * percentageBasisPoints, 10000);
}

int _roundHalfUp(int numerator, int denominator) {
  if (numerator >= 0) return (numerator + denominator ~/ 2) ~/ denominator;
  return -((-numerator + denominator ~/ 2) ~/ denominator);
}
