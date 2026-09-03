import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../core/formatters/money.dart';
import '../application/catalog_providers.dart';
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
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Saving…' : 'Save'),
        ),
      ],
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
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Required' : null,
      ),
    );
  }

  Future<void> _save() async {
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
