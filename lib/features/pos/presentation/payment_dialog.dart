import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../core/formatters/money.dart';
import '../../../core/services/app_haptics.dart';
import '../../checkout/application/checkout_providers.dart';
import '../../checkout/domain/sale_quote.dart';
import '../application/cart_controller.dart';

class PaymentDialog extends ConsumerStatefulWidget {
  const PaymentDialog({super.key, required this.quote});
  final SaleQuote quote;

  @override
  ConsumerState<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends ConsumerState<PaymentDialog> {
  String _method = 'CASH';
  final _cash = TextEditingController();
  final _reference = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _cash.dispose();
    _reference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? cash;
    try {
      cash = _cash.text.trim().isEmpty ? null : parsePhp(_cash.text);
    } catch (_) {}
    final change = cash == null ? null : cash - widget.quote.totalAmount;
    return AlertDialog(
      title: const Text('Payment'),
      content: SizedBox(
        width: 430,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formatPhp(widget.quote.totalAmount),
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'CASH',
                  label: Text('Cash'),
                  icon: Icon(Icons.payments),
                ),
                ButtonSegment(
                  value: 'GCASH',
                  label: Text('GCash'),
                  icon: Icon(Icons.phone_android),
                ),
              ],
              selected: {_method},
              onSelectionChanged: _saving
                  ? null
                  : (value) async {
                      await AppHaptics.selection();
                      if (mounted) setState(() => _method = value.single);
                    },
            ),
            if (_method == 'CASH') ...[
              const SizedBox(height: 18),
              TextField(
                key: const Key('cash-received-field'),
                controller: _cash,
                onChanged: (_) => setState(() {}),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Cash received',
                  prefixText: '₱',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Change'),
                  Text(
                    change == null || change < 0 ? '—' : formatPhp(change),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 18),
              TextField(
                controller: _reference,
                enabled: !_saving,
                maxLength: 80,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'GCash / Maya transaction reference',
                  prefixIcon: Icon(Icons.tag),
                ),
              ),
            ],
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
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
          onPressed: _saving ? null : _complete,
          child: Text(_saving ? 'Completing…' : 'Complete sale'),
        ),
      ],
    );
  }

  Future<void> _complete() async {
    await AppHaptics.medium();
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final cash = _method == 'CASH' ? parsePhp(_cash.text) : null;
      final result = await ref
          .read(checkoutServiceProvider)
          .complete(
            cart: ref.read(cartProvider).lines,
            paymentMethod: _method,
            cashReceived: cash,
            paymentReference: _method == 'GCASH' ? _reference.text : null,
          );
      ref.read(cartProvider.notifier).clear();
      await AppHaptics.success();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sale #${result.sale.transactionNumber.toString().padLeft(6, '0')} completed',
            ),
          ),
        );
      }
    } on ValidationException catch (error) {
      setState(() => _error = error.message);
    } catch (_) {
      setState(
        () => _error = 'Unable to complete the sale. Nothing was changed.',
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
