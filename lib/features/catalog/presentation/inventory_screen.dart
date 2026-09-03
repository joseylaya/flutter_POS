import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatters/money.dart';
import '../application/catalog_providers.dart';
import '../domain/catalog_item.dart';
import 'stock_adjustment_dialog.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(activeCatalogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: catalog.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Unable to load inventory\n$error')),
        data: (items) => items.isEmpty
            ? const Center(
                child: Text('Add a product to begin tracking inventory.'),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, index) => _InventoryCard(item: items[index]),
              ),
      ),
    );
  }
}

class _InventoryCard extends StatelessWidget {
  const _InventoryCard({required this.item});

  final CatalogItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final warning = item.isNegativeStock
        ? ('NEGATIVE STOCK', colorScheme.error)
        : item.isLowStock
        ? ('LOW STOCK', colorScheme.tertiary)
        : ('IN STOCK', colorScheme.primary);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Cost ${formatPhp(item.costPerUnit)} / ${item.unit} • Low at ${item.lowStockThreshold}',
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${item.stockQuantity} ${item.unit}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  warning.$1,
                  style: TextStyle(
                    color: warning.$2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => StockAdjustmentDialog(item: item, add: false),
              ),
              icon: const Icon(Icons.remove),
              label: const Text('Remove'),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => StockAdjustmentDialog(item: item, add: true),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
