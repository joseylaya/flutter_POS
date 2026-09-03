import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/validation_exception.dart';
import '../application/catalog_providers.dart';
import '../domain/catalog_item.dart';

class StockAdjustmentDialog extends ConsumerStatefulWidget {
  const StockAdjustmentDialog({
    super.key,
    required this.item,
    required this.add,
  });

  final CatalogItem item;
  final bool add;

  @override
  ConsumerState<StockAdjustmentDialog> createState() =>
      _StockAdjustmentDialogState();
}

class _StockAdjustmentDialogState extends ConsumerState<StockAdjustmentDialog> {
  final _quantity = TextEditingController();
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.add ? 'Add stock' : 'Remove stock'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              'Current stock: ${widget.item.stockQuantity} ${widget.item.unit}',
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('stock-quantity-field'),
              controller: _quantity,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity (${widget.item.unit})',
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('confirm-stock-adjustment'),
          onPressed: _saving ? null : _submit,
          child: Text(
            _saving
                ? 'Saving…'
                : widget.add
                ? 'Add stock'
                : 'Remove stock',
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    final quantity = int.tryParse(_quantity.text.trim());
    if (quantity == null || quantity <= 0) {
      setState(() => _error = 'Enter a whole number greater than zero.');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final repository = ref.read(catalogRepositoryProvider);
      if (widget.add) {
        await repository.addStock(widget.item.inventoryItemId, quantity);
      } else {
        await repository.removeStock(widget.item.inventoryItemId, quantity);
      }
      if (mounted) Navigator.pop(context);
    } on ValidationException catch (error) {
      setState(() => _error = error.message);
    } catch (_) {
      setState(() => _error = 'Unable to adjust stock.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
