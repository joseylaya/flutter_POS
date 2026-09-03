import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatters/money.dart';
import '../../../core/services/app_haptics.dart';
import '../../catalog/application/catalog_providers.dart';
import '../../catalog/domain/catalog_item.dart';
import '../../checkout/domain/sale_quote.dart';
import '../../discounts/application/discount_providers.dart';
import '../../discounts/domain/active_discount.dart';
import '../application/cart_controller.dart';
import '../domain/cart.dart';
import 'discount_dialog.dart';
import 'checkout_screen.dart';

class PosScreen extends ConsumerStatefulWidget {
  const PosScreen({super.key});
  @override
  ConsumerState<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends ConsumerState<PosScreen> {
  final search = TextEditingController();
  bool addMode = true;
  String selectedCategory = 'All menu';
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(activeCatalogProvider);
    final cart = ref.watch(cartProvider);
    final discount = ref.watch(activeDiscountProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Point of Sale',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            Text(
              'Choose items for the current order',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          if (discount != null)
            Chip(
              avatar: const Icon(Icons.verified_outlined, size: 17),
              label: Text(
                '${discount.name} ${(discount.percentageBasisPoints / 100).toStringAsFixed(0)}%',
              ),
            ),
          IconButton(
            tooltip: 'Configure discount',
            onPressed: catalog.valueOrNull == null
                ? null
                : () => showDialog<void>(
                    context: context,
                    builder: (_) => DiscountDialog(
                      products: catalog.valueOrNull!,
                      activeDiscount: discount,
                    ),
                  ),
            icon: const Icon(Icons.sell_outlined),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: catalog.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Unable to load POS\n$e')),
        data: (products) {
          final query = search.text.trim().toLowerCase();
          final filtered = products
              .where(
                (p) =>
                    p.name.toLowerCase().contains(query) &&
                    (selectedCategory == 'All menu' ||
                        p.category == selectedCategory),
              )
              .toList();
          return LayoutBuilder(
            builder: (context, size) {
              final menu = _Menu(
                products: filtered,
                allProducts: products,
                search: search,
                changed: () => setState(() {}),
                addMode: addMode,
                onModeChanged: (value) => setState(() => addMode = value),
                selectedCategory: selectedCategory,
                onCategoryChanged: (value) =>
                    setState(() => selectedCategory = value),
              );
              final order = _OrderPanel(cart: cart, discount: discount);
              return size.maxWidth >= 900
                  ? Row(
                      children: [
                        Expanded(child: menu),
                        SizedBox(
                          width: size.maxWidth >= 1200 ? 410 : 365,
                          child: order,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(child: menu),
                        _MobileCart(
                          cart: cart,
                          discount: discount,
                          order: order,
                        ),
                      ],
                    );
            },
          );
        },
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    required this.products,
    required this.allProducts,
    required this.search,
    required this.changed,
    required this.addMode,
    required this.onModeChanged,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });
  final List<CatalogItem> products;
  final List<CatalogItem> allProducts;
  final TextEditingController search;
  final VoidCallback changed;
  final bool addMode;
  final ValueChanged<bool> onModeChanged;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
    child: Column(
      children: [
        LayoutBuilder(
          builder: (context, size) {
            final searchField = TextField(
              controller: search,
              onChanged: (_) => changed(),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search silog, sides, and drinks…',
              ),
            );
            final modeControl = SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: true,
                  icon: Icon(Icons.add_circle_outline, size: 27),
                  label: Text('Add'),
                ),
                ButtonSegment(
                  value: false,
                  icon: Icon(Icons.remove_circle_outline, size: 27),
                  label: Text('Remove'),
                ),
              ],
              selected: {addMode},
              onSelectionChanged: (value) async {
                await AppHaptics.selection();
                onModeChanged(value.single);
              },
              style: ButtonStyle(
                minimumSize: const WidgetStatePropertyAll(Size(108, 56)),
                textStyle: const WidgetStatePropertyAll(
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                ),
                backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? (addMode
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFFEF4444))
                      : null,
                ),
                foregroundColor: WidgetStateProperty.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? Colors.black
                      : null,
                ),
              ),
            );
            return size.maxWidth < 620
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      searchField,
                      const SizedBox(height: 10),
                      modeControl,
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: searchField),
                      const SizedBox(width: 12),
                      modeControl,
                    ],
                  );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Icon(
                addMode ? Icons.touch_app_outlined : Icons.backspace_outlined,
                size: 17,
                color: addMode
                    ? const Color(0xFFF59E0B)
                    : const Color(0xFFEF4444),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  addMode
                      ? 'Tap a product to add one to the order'
                      : 'Tap a product to remove one from the order',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: addMode
                        ? const Color(0xFFF59E0B)
                        : const Color(0xFFEF4444),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _Filter(
                'All menu',
                selected: selectedCategory == 'All menu',
                count: allProducts.length,
                onSelected: onCategoryChanged,
              ),
              _Filter(
                'Silog Meals',
                icon: Icons.egg_alt_outlined,
                selected: selectedCategory == 'Silog Meals',
                count: allProducts
                    .where((p) => p.category == 'Silog Meals')
                    .length,
                onSelected: onCategoryChanged,
              ),
              _Filter(
                'Sides & Add-ons',
                icon: Icons.bakery_dining_outlined,
                selected: selectedCategory == 'Sides & Add-ons',
                count: allProducts
                    .where((p) => p.category == 'Sides & Add-ons')
                    .length,
                onSelected: onCategoryChanged,
              ),
              _Filter(
                'Drinks',
                icon: Icons.local_cafe_outlined,
                selected: selectedCategory == 'Drinks',
                count: allProducts.where((p) => p.category == 'Drinks').length,
                onSelected: onCategoryChanged,
              ),
              if (allProducts.any((p) => p.category == 'Other'))
                _Filter(
                  'Other',
                  icon: Icons.more_horiz,
                  selected: selectedCategory == 'Other',
                  count: allProducts.where((p) => p.category == 'Other').length,
                  onSelected: onCategoryChanged,
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: products.isEmpty
              ? const Center(child: Text('No matching products'))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 290,
                    childAspectRatio: .82,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: products.length,
                  itemBuilder: (_, i) =>
                      _ProductCard(products[i], i, addMode: addMode),
                ),
        ),
      ],
    ),
  );
}

class _Filter extends StatelessWidget {
  const _Filter(
    this.label, {
    this.icon,
    this.count,
    this.selected = false,
    required this.onSelected,
  });
  final String label;
  final IconData? icon;
  final int? count;
  final bool selected;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 10),
    child: ChoiceChip(
      selected: selected,
      onSelected: (_) => onSelected(label),
      showCheckmark: false,
      avatar: icon == null ? null : Icon(icon, size: 18),
      label: Text(count == null ? label : '$label  $count'),
    ),
  );
}

class _ProductCard extends ConsumerStatefulWidget {
  const _ProductCard(this.item, this.index, {required this.addMode});
  final CatalogItem item;
  final int index;
  final bool addMode;

  @override
  ConsumerState<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<_ProductCard> {
  int feedbackTick = 0;

  Future<void> _updateCart() async {
    final cart = ref.read(cartProvider);
    final exists = cart.lines.any(
      (line) => line.item.productId == widget.item.productId,
    );
    if (!widget.addMode && !exists) return;

    await AppHaptics.light();
    widget.addMode
        ? ref.read(cartProvider.notifier).add(widget.item)
        : ref.read(cartProvider.notifier).decrement(widget.item);
    setState(() => feedbackTick++);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final cart = ref.watch(cartProvider);
    final cartIndex = cart.lines.indexWhere(
      (line) => line.item.productId == item.productId,
    );
    final orderQuantity = cartIndex == -1 ? 0 : cart.lines[cartIndex].quantity;
    final unavailable = item.stockQuantity <= 0;
    final status = unavailable ? 'Out of stock' : '${item.stockQuantity} left';
    final statusColor = unavailable
        ? const Color(0xFFEF4444)
        : item.isLowStock
        ? const Color(0xFFF59E0B)
        : const Color(0xFF10B981);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('pos-product-${item.productId}'),
        onTap: unavailable && widget.addMode ? null : _updateCart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ColorFiltered(
                    colorFilter: unavailable
                        ? const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          )
                        : const ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.multiply,
                          ),
                    child: item.imageData == null
                        ? Image.asset(
                            'assets/images/silog-hero.png',
                            fit: BoxFit.cover,
                            alignment: Alignment(
                              0,
                              (widget.index % 3 - 1) * .18,
                            ),
                          )
                        : Image.memory(item.imageData!, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: .94),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  if (orderQuantity > 0)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 160),
                        child: Container(
                          key: ValueKey(orderQuantity),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            '$orderQuantity in order',
                            style: const TextStyle(
                              color: Color(0xFF181000),
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (feedbackTick > 0)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Center(
                          child: TweenAnimationBuilder<double>(
                            key: ValueKey(feedbackTick),
                            tween: Tween(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 650),
                            curve: Curves.easeOutCubic,
                            builder: (context, progress, child) => Opacity(
                              opacity: 1 - progress,
                              child: Transform.translate(
                                offset: Offset(0, -42 * progress),
                                child: Transform.scale(
                                  scale: .85 + (.2 * (1 - progress)),
                                  child: child,
                                ),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    (widget.addMode
                                            ? const Color(0xFF10B981)
                                            : const Color(0xFFEF4444))
                                        .withValues(alpha: .94),
                                borderRadius: BorderRadius.circular(99),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                widget.addMode ? '+1' : '−1',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '${item.stockQuantity} ${item.unit} available',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formatPhp(item.sellingPrice),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderPanel extends ConsumerWidget {
  const _OrderPanel({required this.cart, required this.discount});
  final CartState cart;
  final ActiveDiscount? discount;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quote = localQuote(cart, discount);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(left: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${cart.itemCount}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Order',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text('Saved locally', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Clear order',
                onPressed: cart.isEmpty
                    ? null
                    : () => ref.read(cartProvider.notifier).clear(),
                icon: const Icon(Icons.delete_sweep_outlined),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_bag_outlined, size: 52),
                        SizedBox(height: 12),
                        Text(
                          'Your order is empty',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text('Tap a product to add it'),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: cart.lines.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final line = cart.lines[i];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      line.item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    formatPhp(quote.lines[i].lineTotal),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '${formatPhp(line.item.sellingPrice)} each',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const Spacer(),
                                  _QuantityStepper(
                                    quantity: line.quantity,
                                    onDecrease: () => ref
                                        .read(cartProvider.notifier)
                                        .setQuantity(
                                          line.item.productId,
                                          line.quantity - 1,
                                        ),
                                    onIncrease: () => ref
                                        .read(cartProvider.notifier)
                                        .setQuantity(
                                          line.item.productId,
                                          line.quantity + 1,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12),
          _Amount('Items subtotal', quote.subtotal),
          if (quote.discountAmount > 0)
            _Amount(
              discount?.name ?? 'Discount',
              -quote.discountAmount,
              accent: true,
            ),
          const Divider(height: 24),
          _Amount('TOTAL DUE', quote.totalAmount, total: true),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: cart.isEmpty
                ? null
                : () async {
                    await AppHaptics.medium();
                    if (!context.mounted) return;
                    await Navigator.of(context).push<void>(
                      MaterialPageRoute(
                        builder: (_) => CheckoutScreen(quote: quote),
                      ),
                    );
                  },
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(58),
              foregroundColor: const Color(0xFF181000),
            ),
            child: Row(
              children: [
                Text(
                  formatPhp(quote.totalAmount),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Spacer(),
                const Text('Proceed to payment'),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            tooltip: 'Remove one',
            icon: Icons.remove_rounded,
            onTap: onDecrease,
          ),
          Container(
            width: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 140),
              child: Text(
                '$quantity',
                key: ValueKey(quantity),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          _StepperButton(
            tooltip: 'Add one',
            icon: Icons.add_rounded,
            onTap: onIncrease,
            emphasized: true,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
    this.emphasized = false,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        await AppHaptics.light();
        onTap();
      },
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          icon,
          size: 20,
          color: emphasized ? const Color(0xFFF59E0B) : null,
        ),
      ),
    ),
  );
}

class _Amount extends StatelessWidget {
  const _Amount(
    this.label,
    this.amount, {
    this.total = false,
    this.accent = false,
  });
  final String label;
  final int amount;
  final bool total;
  final bool accent;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: total ? FontWeight.w900 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          formatPhp(amount),
          style: TextStyle(
            fontSize: total ? 25 : 14,
            color: accent ? const Color(0xFFF59E0B) : null,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    ),
  );
}

class _MobileCart extends StatelessWidget {
  const _MobileCart({
    required this.cart,
    required this.discount,
    required this.order,
  });
  final CartState cart;
  final ActiveDiscount? discount;
  final Widget order;
  @override
  Widget build(BuildContext context) {
    final quote = localQuote(cart, discount);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: FilledButton(
          onPressed: cart.isEmpty
              ? null
              : () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => SizedBox(
                    height: MediaQuery.sizeOf(context).height * .88,
                    child: order,
                  ),
                ),
          child: Row(
            children: [
              const Icon(Icons.shopping_bag_outlined),
              const SizedBox(width: 8),
              Text('${cart.itemCount} items'),
              const Spacer(),
              Text(
                formatPhp(quote.totalAmount),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

SaleQuote localQuote(CartState cart, ActiveDiscount? discount) => SaleQuote(
  lines: cart.lines.map((line) {
    final basisPoints = discount?.appliesTo(line.item.productId) == true
        ? discount!.percentageBasisPoints
        : 0;
    final subtotal = line.item.sellingPrice * line.quantity;
    final reduction = roundDiscount(subtotal, basisPoints);
    return SaleLineQuote(
      productId: line.item.productId,
      productName: line.item.name,
      quantity: line.quantity,
      baseUnitPrice: line.item.sellingPrice,
      discountBasisPoints: basisPoints,
      lineSubtotal: subtotal,
      lineDiscount: reduction,
      lineTotal: subtotal - reduction,
      costPerUnit: line.item.costPerUnit,
      lineCost: line.item.costPerUnit * line.quantity,
    );
  }).toList(),
);
