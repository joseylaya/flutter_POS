import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatters/money.dart';
import '../application/catalog_providers.dart';
import '../domain/catalog_item.dart';
import 'product_form_dialog.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(activeCatalogProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('add-product-button'),
        onPressed: () => showDialog<void>(
          context: context,
          builder: (_) => const ProductFormDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add product'),
      ),
      body: catalog.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Unable to load products\n$error')),
        data: (items) => items.isEmpty
            ? const _EmptyState()
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, index) => _ProductCard(item: items[index]),
              ),
      ),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({required this.item});

  final CatalogItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundImage: item.imageData == null
              ? null
              : MemoryImage(item.imageData!),
          child: item.imageData == null
              ? Text(item.name.characters.first.toUpperCase())
              : null,
        ),
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${item.category} • ${item.stockQuantity} ${item.unit} • Cost ${formatPhp(item.costPerUnit)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formatPhp(item.sellingPrice),
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            PopupMenuButton<String>(
              onSelected: (action) async {
                if (action == 'edit') {
                  await showDialog<void>(
                    context: context,
                    builder: (_) => ProductFormDialog(item: item),
                  );
                } else {
                  await ref
                      .read(catalogRepositoryProvider)
                      .setActive(item.productId, isActive: false);
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'deactivate', child: Text('Deactivate')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.restaurant_menu, size: 64),
        SizedBox(height: 16),
        Text(
          'No products yet',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8),
        Text('Add the first product to begin building your POS catalog.'),
      ],
    ),
  );
}
