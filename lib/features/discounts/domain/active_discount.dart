class ActiveDiscount {
  const ActiveDiscount({
    required this.id,
    required this.name,
    required this.percentageBasisPoints,
    required this.scope,
    required this.productIds,
  });

  final String id;
  final String name;
  final int percentageBasisPoints;
  final String scope;
  final Set<String> productIds;

  bool appliesTo(String productId) =>
      scope == 'ALL' || productIds.contains(productId);
}
