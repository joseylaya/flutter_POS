import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../core/formatters/money.dart';
import '../application/catalog_providers.dart';
import '../data/catalog_repository.dart';
import '../domain/catalog_item.dart';

class ProductFormDialog extends ConsumerStatefulWidget {
  const ProductFormDialog({super.key, this.item});

  final CatalogItem? item;

  @override
  ConsumerState<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends ConsumerState<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _price;
  late final TextEditingController _stock;
  late final TextEditingController _unit;
  late final TextEditingController _cost;
  late final TextEditingController _threshold;
  String? _error;
  bool _saving = false;
  Uint8List? _image;
  late String _category;
  final Map<String, int> _inclusions = {};
  bool _inclusionsLoaded = false;
  bool _inclusionsLoadFailed = false;

  bool get _editing => widget.item != null;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _image = item?.imageData;
    _category = item?.category ?? 'Silog Meals';
    _name = TextEditingController(text: item?.name ?? '');
    _price = TextEditingController(
      text: item == null ? '' : (item.sellingPrice / 100).toStringAsFixed(2),
    );
    _stock = TextEditingController(text: item?.stockQuantity.toString() ?? '0');
    _unit = TextEditingController(text: item?.unit ?? 'serving');
    _cost = TextEditingController(
      text: item == null ? '' : (item.costPerUnit / 100).toStringAsFixed(2),
    );
    _threshold = TextEditingController(
      text: item?.lowStockThreshold.toString() ?? '5',
    );
    _loadInclusions();
  }

  Future<void> _loadInclusions() async {
    try {
      final item = widget.item;
      if (item != null) {
        final inclusions = await ref
            .read(catalogRepositoryProvider)
            .getProductInclusions(item.productId);
        for (final inclusion in inclusions) {
          _inclusions[inclusion.inventoryItemId] = inclusion.quantity;
        }
      }
      if (mounted) setState(() => _inclusionsLoaded = true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _inclusionsLoaded = true;
          _inclusionsLoadFailed = true;
          _error =
              'Unable to load product inclusions. Try reopening this form.';
        });
      }
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _name,
      _price,
      _stock,
      _unit,
      _cost,
      _threshold,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_editing ? 'Edit product' : 'Add product'),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _imagePicker(context),
                const SizedBox(height: 16),
                _field(_name, 'Product name'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items:
                        const [
                              'Silog Meals',
                              'Sides & Add-ons',
                              'Drinks',
                              'Other',
                            ]
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                    onChanged: _saving
                        ? null
                        : (value) => setState(() => _category = value!),
                  ),
                ),
                _field(_price, 'Selling price', prefix: '₱', decimal: true),
                if (!_editing) _field(_stock, 'Initial stock', integer: true),
                _field(_unit, 'Unit (serving, bottle, piece)'),
                _field(_cost, 'Cost per unit', prefix: '₱', decimal: true),
                _field(_threshold, 'Low-stock threshold', integer: true),
                _inclusionEditor(),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving || !_inclusionsLoaded || _inclusionsLoadFailed
              ? null
              : _save,
          child: Text(_saving ? 'Saving…' : 'Save'),
        ),
      ],
    );
  }

  Widget _inclusionEditor() {
    final catalog = ref.watch(activeCatalogProvider);
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          Text('Inclusions', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            'Select existing inventory deducted whenever this product is sold. Zero-stock items are allowed.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          if (!_inclusionsLoaded)
            const Center(child: CircularProgressIndicator())
          else if (_inclusionsLoadFailed)
            const Text('Inclusions could not be loaded safely.')
          else
            catalog.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const Text('Unable to load inventory items.'),
              data: (items) {
                final choices = items
                    .where(
                      (item) =>
                          item.inventoryItemId != widget.item?.inventoryItemId,
                    )
                    .toList();
                if (choices.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Add another inventory product first to use it as an inclusion.',
                    ),
                  );
                }
                return Column(
                  children: choices.map((item) {
                    final selected = _inclusions.containsKey(
                      item.inventoryItemId,
                    );
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: selected,
                              onChanged: _saving
                                  ? null
                                  : (value) => setState(() {
                                      if (value == true) {
                                        _inclusions[item.inventoryItemId] = 1;
                                      } else {
                                        _inclusions.remove(
                                          item.inventoryItemId,
                                        );
                                      }
                                    }),
                            ),
                            Expanded(
                              child: Text(
                                '${item.name} (${item.stockQuantity} ${item.unit})',
                              ),
                            ),
                            if (selected)
                              SizedBox(
                                width: 86,
                                child: TextFormField(
                                  key: ValueKey(
                                    'inclusion-${item.inventoryItemId}',
                                  ),
                                  initialValue:
                                      _inclusions[item.inventoryItemId]
                                          .toString(),
                                  decoration: const InputDecoration(
                                    labelText: 'Qty',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    final quantity = int.tryParse(
                                      value?.trim() ?? '',
                                    );
                                    return quantity == null || quantity <= 0
                                        ? 'Invalid'
                                        : null;
                                  },
                                  onChanged: (value) {
                                    final quantity = int.tryParse(value.trim());
                                    if (quantity != null) {
                                      _inclusions[item.inventoryItemId] =
                                          quantity;
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _imagePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 190,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: _image == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined, size: 46),
                      SizedBox(height: 8),
                      Text('No product image selected'),
                    ],
                  )
                : Image.memory(_image!, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _saving ? null : _pickImage,
                icon: const Icon(Icons.upload_outlined),
                label: Text(_image == null ? 'Upload image' : 'Replace image'),
              ),
            ),
            if (_image != null) ...[
              const SizedBox(width: 8),
              IconButton.filledTonal(
                tooltip: 'Remove image',
                onPressed: _saving ? null : () => setState(() => _image = null),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            'Stored locally for offline use. JPEG, PNG, or WebP up to 5 MB.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final selected = await FilePicker.pickFile(type: FileType.image);
    final bytes = await selected?.readAsBytes();
    if (bytes == null) return;
    if (bytes.lengthInBytes > 5 * 1024 * 1024) {
      setState(() => _error = 'Product image must be 5 MB or smaller.');
      return;
    }
    setState(() {
      _image = bytes;
      _error = null;
    });
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    String? prefix,
    bool decimal = false,
    bool integer = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, prefixText: prefix),
        keyboardType: decimal
            ? const TextInputType.numberWithOptions(decimal: true)
            : integer
            ? TextInputType.number
            : TextInputType.text,
        maxLength: controller == _name
            ? 120
            : controller == _unit
            ? 30
            : null,
        validator: (value) {
          final text = value?.trim() ?? '';
          if (text.isEmpty) return 'Required';
          if (integer) {
            final parsed = int.tryParse(text);
            if (parsed == null) return 'Enter a whole number';
            if (parsed < 0) return 'Cannot be negative';
          }
          if (decimal) {
            try {
              parsePhp(text);
            } on ValidationException catch (error) {
              return error.message;
            }
          }
          return null;
        },
      ),
    );
  }

  Future<void> _save() async {
    if (_saving || !_inclusionsLoaded || _inclusionsLoadFailed) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final repository = ref.read(catalogRepositoryProvider);
      final price = parsePhp(_price.text);
      final cost = parsePhp(_cost.text);
      final threshold = int.parse(_threshold.text.trim());
      final inclusions = _inclusions.entries
          .map(
            (entry) => ProductInclusionInput(
              inventoryItemId: entry.key,
              quantity: entry.value,
            ),
          )
          .toList(growable: false);
      if (_editing) {
        await repository.updateProduct(
          productId: widget.item!.productId,
          name: _name.text,
          category: _category,
          sellingPrice: price,
          unit: _unit.text,
          costPerUnit: cost,
          lowStockThreshold: threshold,
          imageData: _image,
          inclusions: inclusions,
        );
      } else {
        await repository.createProduct(
          name: _name.text,
          category: _category,
          sellingPrice: price,
          initialStock: int.parse(_stock.text.trim()),
          unit: _unit.text,
          costPerUnit: cost,
          lowStockThreshold: threshold,
          imageData: _image,
          inclusions: inclusions,
        );
      }
      if (mounted) Navigator.pop(context);
    } on FormatException {
      setState(() => _error = 'Stock and threshold must be whole numbers.');
    } on ValidationException catch (error) {
      setState(() => _error = error.message);
    } catch (_) {
      setState(() => _error = 'Unable to save the product.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
