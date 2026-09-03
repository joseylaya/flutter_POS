import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../core/formatters/money.dart';
import '../../catalog/domain/catalog_item.dart';
import '../../discounts/application/discount_providers.dart';
import '../../discounts/domain/active_discount.dart';

class DiscountDialog extends ConsumerStatefulWidget {
  const DiscountDialog({
    super.key,
    required this.products,
    required this.activeDiscount,
  });
  final List<CatalogItem> products;
  final ActiveDiscount? activeDiscount;

  @override
  ConsumerState<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends ConsumerState<DiscountDialog> {
  late final TextEditingController _name;
  late final TextEditingController _percentage;
  late String _scope;
  late Set<String> _selected;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final active = widget.activeDiscount;
    _name = TextEditingController(text: active?.name ?? 'Discount');
    _percentage = TextEditingController(
      text: active == null
          ? '10'
          : (active.percentageBasisPoints / 100).toString(),
    );
    _scope = active?.scope ?? 'ALL';
    _selected = {...?active?.productIds};
  }

  @override
  void dispose() {
    _name.dispose();
    _percentage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Discount'),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Discount name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _percentage,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Percentage',
                  suffixText: '%',
                ),
              ),
              const SizedBox(height: 12),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'ALL', label: Text('All products')),
                  ButtonSegment(
                    value: 'SELECTED',
                    label: Text('Selected only'),
                  ),
                ],
                selected: {_scope},
                onSelectionChanged: (value) =>
                    setState(() => _scope = value.single),
              ),
              if (_scope == 'SELECTED') ...[
                const SizedBox(height: 10),
                ...widget.products.map(
                  (product) => CheckboxListTile(
                    value: _selected.contains(product.productId),
                    title: Text(product.name),
                    dense: true,
                    onChanged: (checked) => setState(() {
                      checked == true
                          ? _selected.add(product.productId)
                          : _selected.remove(product.productId);
                    }),
                  ),
                ),
              ],
              if (_error != null)
                Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
      ),
      actions: [
        if (widget.activeDiscount != null)
          TextButton(
            onPressed: _saving ? null : _disable,
            child: const Text('Disable'),
          ),
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _activate,
          child: Text(_saving ? 'Saving…' : 'Enable'),
        ),
      ],
    );
  }

  Future<void> _activate() => _run(() async {
    await ref
        .read(discountRepositoryProvider)
        .activate(
          name: _name.text,
          percentageBasisPoints: parsePhp(_percentage.text),
          scope: _scope,
          productIds: _selected,
        );
  });

  Future<void> _disable() =>
      _run(() => ref.read(discountRepositoryProvider).disable());

  Future<void> _run(Future<void> Function() operation) async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await operation();
      if (mounted) Navigator.pop(context);
    } on ValidationException catch (error) {
      setState(() => _error = error.message);
    } catch (_) {
      setState(() => _error = 'Unable to update the discount.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
