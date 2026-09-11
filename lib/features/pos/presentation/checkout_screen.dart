import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../core/formatters/money.dart';
import '../../../core/services/app_haptics.dart';
import '../../checkout/application/checkout_providers.dart';
import '../../checkout/domain/sale_quote.dart';
import '../../printing/receipt_service.dart';
import '../../reports/application/report_providers.dart';
import '../../settings/application/settings_providers.dart';
import '../application/cart_controller.dart';
import 'sale_complete_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key, required this.quote});
  final SaleQuote quote;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int step = 0;
  String? orderType;
  String? fulfillmentType;
  String method = 'CASH';
  String cashDigits = '';
  String gcashReference = '';
  bool saving = false;
  String? error;

  int? get cashReceived =>
      cashDigits.isEmpty ? null : int.parse(cashDigits) * 100;
  int? get change =>
      cashReceived == null ? null : cashReceived! - widget.quote.totalAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        leading: IconButton.filledTonal(
          tooltip: 'Back to order',
          onPressed: saving ? null : _back,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Checkout order',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            Text(
              '${widget.quote.lines.fold<int>(0, (sum, line) => sum + line.quantity)} items • ${_stepTitle()}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: const [
          Chip(
            avatar: Icon(Icons.shield_outlined, size: 18),
            label: Text('Stored locally'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          _CheckoutProgress(step: step, orderType: orderType),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: switch (step) {
                0 => _OrderTypePage(
                  key: const ValueKey('order-type'),
                  selected: orderType,
                  onSelected: (value) => setState(() {
                    orderType = value;
                    if (value == 'DINE_IN') fulfillmentType = null;
                    error = null;
                  }),
                  onContinue: orderType == null ? null : _continueOrderType,
                ),
                1 => _FulfillmentPage(
                  key: const ValueKey('fulfillment'),
                  selected: fulfillmentType,
                  onSelected: (value) => setState(() {
                    fulfillmentType = value;
                    error = null;
                  }),
                  onContinue: fulfillmentType == null
                      ? null
                      : () => setState(() => step = 2),
                ),
                _ => _paymentPage(),
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentPage() => LayoutBuilder(
    builder: (context, size) {
      final left = _OrderReview(quote: widget.quote);
      final right = _PaymentPanel(
        quote: widget.quote,
        method: method,
        cashReceived: cashReceived,
        change: change,
        saving: saving,
        error: error,
        gcashReference: gcashReference,
        onMethod: _setMethod,
        onCash: _setCash,
        onKey: _key,
        onReference: (value) => setState(() {
          gcashReference = value;
          error = null;
        }),
        onComplete: _complete,
        orderLabel: orderType == 'DINE_IN'
            ? 'Dine in'
            : 'Take out • ${fulfillmentType == 'DELIVERY' ? 'Delivery' : 'Pickup'}',
      );
      if (size.maxWidth >= 900) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.maxWidth * .36,
                child: SingleChildScrollView(child: left),
              ),
              const SizedBox(width: 12),
              Expanded(child: right),
            ],
          ),
        );
      }
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [left, const SizedBox(height: 16), right],
      );
    },
  );

  String _stepTitle() => switch (step) {
    0 => 'Choose order type',
    1 => 'Choose take-out method',
    _ => 'Review and collect payment',
  };

  void _continueOrderType() {
    setState(() => step = orderType == 'TAKE_OUT' ? 1 : 2);
  }

  void _back() {
    if (step == 0) {
      Navigator.pop(context);
    } else {
      setState(() => step = step == 2 && orderType == 'DINE_IN' ? 0 : step - 1);
    }
  }

  Future<void> _setMethod(String value) async {
    await AppHaptics.selection();
    if (mounted) {
      setState(() {
        method = value;
        error = null;
      });
    }
  }

  Future<void> _setCash(int amount) async {
    await AppHaptics.selection();
    if (mounted) {
      setState(() {
        cashDigits = (amount ~/ 100).toString();
        error = null;
      });
    }
  }

  Future<void> _key(String key) async {
    await AppHaptics.light();
    if (!mounted) return;
    setState(() {
      if (key == 'C') {
        cashDigits = '';
      } else if (cashDigits.length < 7) {
        cashDigits += key;
      }
      error = null;
    });
  }

  Future<void> _complete() async {
    if (saving) return;
    await AppHaptics.medium();
    setState(() {
      saving = true;
      error = null;
    });
    try {
      if (method == 'GCASH' && gcashReference.trim().isEmpty) {
        throw const ValidationException(
          'Enter the GCash or Maya transaction reference.',
        );
      }
      if (orderType == null) {
        throw const ValidationException('Select Dine in or Take out.');
      }
      final result = await ref
          .read(checkoutServiceProvider)
          .complete(
            cart: ref.read(cartProvider).lines,
            paymentMethod: method,
            cashReceived: method == 'CASH' ? cashReceived : null,
            paymentReference: method == 'GCASH' ? gcashReference : null,
            orderType: orderType!,
            fulfillmentType: fulfillmentType,
          );
      ref.read(cartProvider.notifier).clear();
      await AppHaptics.success();

      String message =
          'Sale #${result.sale.transactionNumber.toString().padLeft(6, '0')} completed.';
      final items = await ref
          .read(reportsRepositoryProvider)
          .saleItems(result.sale.id);
      final settings = await ref.read(settingsRepositoryProvider).get();
      try {
        await ReceiptService().printReceipt(
          settings: settings,
          sale: result.sale,
          items: items,
        );
        await AppHaptics.light();
        message += ' Receipt printed.';
      } catch (printError) {
        message += ' $printError';
      }
      if (!mounted) return;
      await Navigator.of(context).pushReplacement<void, void>(
        MaterialPageRoute(
          builder: (_) => SaleCompleteScreen(
            sale: result.sale,
            items: items,
            settings: settings,
            receiptMessage: message,
          ),
        ),
      );
    } on ValidationException catch (value) {
      setState(() => error = value.message);
    } catch (_) {
      setState(
        () => error = 'Unable to complete the sale. Nothing was changed.',
      );
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }
}

class _CheckoutProgress extends StatelessWidget {
  const _CheckoutProgress({required this.step, required this.orderType});

  final int step;
  final String? orderType;

  @override
  Widget build(BuildContext context) {
    final stages = orderType == 'TAKE_OUT'
        ? const ['Order type', 'Take-out method', 'Payment']
        : const ['Order type', 'Payment'];
    final activeStage = orderType == 'TAKE_OUT' ? step : (step == 2 ? 1 : 0);
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 7, 20, 9),
        child: Row(
          children: [
            for (var index = 0; index < stages.length; index++) ...[
              if (index > 0)
                Expanded(
                  child: Divider(
                    color: index <= activeStage
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    thickness: 2,
                  ),
                ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: index <= activeStage
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    foregroundColor: index <= activeStage
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    child: index < activeStage
                        ? const Icon(Icons.check, size: 17)
                        : Text('${index + 1}'),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stages[index],
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OrderTypePage extends StatelessWidget {
  const _OrderTypePage({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.onContinue,
  });

  final String? selected;
  final ValueChanged<String> onSelected;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) => _ChoicePage(
    title: 'How will this order be served?',
    subtitle: 'Choose one option to continue to payment.',
    choices: [
      _Choice(
        value: 'DINE_IN',
        title: 'Dine in',
        subtitle: 'The customer will eat at the restaurant.',
        icon: Icons.restaurant,
      ),
      _Choice(
        value: 'TAKE_OUT',
        title: 'Take out',
        subtitle: 'The order will be picked up or delivered.',
        icon: Icons.shopping_bag_outlined,
      ),
    ],
    selected: selected,
    onSelected: onSelected,
    onContinue: onContinue,
  );
}

class _FulfillmentPage extends StatelessWidget {
  const _FulfillmentPage({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.onContinue,
  });

  final String? selected;
  final ValueChanged<String> onSelected;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) => _ChoicePage(
    title: 'How will the take-out order be received?',
    subtitle: 'Choose Delivery or Pickup.',
    choices: const [
      _Choice(
        value: 'DELIVERY',
        title: 'Delivery',
        subtitle: 'The order will be delivered to the customer.',
        icon: Icons.delivery_dining,
      ),
      _Choice(
        value: 'PICKUP',
        title: 'Pickup',
        subtitle: 'The customer will collect the order.',
        icon: Icons.storefront_outlined,
      ),
    ],
    selected: selected,
    onSelected: onSelected,
    onContinue: onContinue,
  );
}

class _Choice {
  const _Choice({
    required this.value,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String value;
  final String title;
  final String subtitle;
  final IconData icon;
}

class _ChoicePage extends StatelessWidget {
  const _ChoicePage({
    required this.title,
    required this.subtitle,
    required this.choices,
    required this.selected,
    required this.onSelected,
    required this.onContinue,
  });

  final String title;
  final String subtitle;
  final List<_Choice> choices;
  final String? selected;
  final ValueChanged<String> onSelected;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            for (final choice in choices)
              Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.only(bottom: 14),
                color: selected == choice.value
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                child: InkWell(
                  onTap: () => onSelected(choice.value),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Row(
                      children: [
                        Icon(choice.icon, size: 38),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                choice.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(choice.subtitle),
                            ],
                          ),
                        ),
                        Icon(
                          selected == choice.value
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: selected == choice.value
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: onContinue,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Continue'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _OrderReview extends StatelessWidget {
  const _OrderReview({required this.quote});
  final SaleQuote quote;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL PAYABLE AMOUNT',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Text(
                formatPhp(quote.totalAmount),
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 14),
              _SummaryRow('Subtotal', quote.subtotal),
              if (quote.discountAmount > 0)
                _SummaryRow('Discount', -quote.discountAmount, accent: true),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Order Items Preview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              for (final line in quote.lines)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${line.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              line.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              '${formatPhp(line.baseUnitPrice)} each',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        formatPhp(line.lineTotal),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.edit_note),
                label: const Text('Add or edit items'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _PaymentPanel extends StatelessWidget {
  const _PaymentPanel({
    required this.quote,
    required this.method,
    required this.cashReceived,
    required this.change,
    required this.saving,
    required this.error,
    required this.gcashReference,
    required this.onMethod,
    required this.onCash,
    required this.onKey,
    required this.onReference,
    required this.onComplete,
    required this.orderLabel,
  });
  final SaleQuote quote;
  final String method;
  final int? cashReceived;
  final int? change;
  final bool saving;
  final String? error;
  final String gcashReference;
  final ValueChanged<String> onMethod;
  final ValueChanged<int> onCash;
  final ValueChanged<String> onKey;
  final ValueChanged<String> onReference;
  final VoidCallback onComplete;
  final String orderLabel;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Chip(
          avatar: const Icon(Icons.restaurant_outlined, size: 18),
          label: Text(orderLabel),
        ),
      ),
      const SizedBox(height: 6),
      SegmentedButton<String>(
        segments: const [
          ButtonSegment(
            value: 'CASH',
            icon: Icon(Icons.payments_outlined),
            label: Text('Cash Tender'),
          ),
          ButtonSegment(
            value: 'GCASH',
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: Text('GCash / Maya'),
          ),
        ],
        selected: {method},
        onSelectionChanged: saving ? null : (value) => onMethod(value.single),
        style: const ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size.fromHeight(48)),
        ),
      ),
      if (method == 'CASH') ...[
        const SizedBox(height: 8),
        Row(
          children: [
            _QuickCash(
              label: 'Exact',
              amount: quote.totalAmount,
              selected: cashReceived == quote.totalAmount,
              onTap: onCash,
            ),
            const SizedBox(width: 8),
            _QuickCash(
              label: 'Common',
              amount: 50000,
              selected: cashReceived == 50000,
              onTap: onCash,
            ),
            const SizedBox(width: 8),
            _QuickCash(
              label: 'Note',
              amount: 100000,
              selected: cashReceived == 100000,
              onTap: onCash,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          color: const Color(0xFF10B981).withValues(alpha: .13),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: _BigAmount(
                    'RECEIVED',
                    cashReceived == null ? '—' : formatPhp(cashReceived!),
                  ),
                ),
                Expanded(
                  child: _BigAmount('DUE BILL', formatPhp(quote.totalAmount)),
                ),
                Expanded(
                  child: _BigAmount(
                    'CHANGE DUE',
                    change == null || change! < 0 ? '—' : formatPhp(change!),
                    green: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      'MANUAL NUMPAD TENDER',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Spacer(),
                    Text(
                      cashReceived == null
                          ? 'Enter cash received'
                          : formatPhp(cashReceived!),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 4.2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  children: [
                    for (final key in const [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      'C',
                      '0',
                      '00',
                    ])
                      FilledButton.tonal(
                        onPressed: saving ? null : () => onKey(key),
                        style: FilledButton.styleFrom(
                          foregroundColor: key == 'C' ? Colors.red : null,
                        ),
                        child: Text(
                          key,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ] else ...[
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'GCash / Maya transaction',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  'Enter the reference shown in the customer payment confirmation for your transaction logs.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: gcashReference,
                  enabled: !saving,
                  autofocus: true,
                  onChanged: onReference,
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 80,
                  decoration: const InputDecoration(
                    labelText: 'Transaction reference',
                    hintText: 'Example: 8291045678912',
                    prefixIcon: Icon(Icons.tag),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline, color: Color(0xFF10B981)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'The reference is stored only on this device and printed on the receipt.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      if (error != null)
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            error!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      const SizedBox(height: 10),
      FilledButton.icon(
        onPressed:
            saving ||
                (method == 'CASH' &&
                    (cashReceived == null ||
                        cashReceived! < quote.totalAmount)) ||
                (method == 'GCASH' && gcashReference.trim().isEmpty)
            ? null
            : onComplete,
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          foregroundColor: const Color(0xFF181000),
        ),
        icon: const Icon(Icons.print_outlined),
        label: Text(
          saving ? 'Completing sale…' : 'Complete Sale & Print Receipt',
          style: const TextStyle(fontSize: 17),
        ),
      ),
    ],
  );
}

class _QuickCash extends StatelessWidget {
  const _QuickCash({
    required this.label,
    required this.amount,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final int amount;
  final bool selected;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) => Expanded(
    child: OutlinedButton(
      onPressed: () => onTap(amount),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        side: selected
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          Text(
            formatPhp(amount),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}

class _BigAmount extends StatelessWidget {
  const _BigAmount(this.label, this.value, {this.green = false});
  final String label;
  final String value;
  final bool green;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Theme.of(context).textTheme.labelMedium),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: green ? const Color(0xFF07875F) : null,
        ),
      ),
    ],
  );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.amount, {this.accent = false});
  final String label;
  final int amount;
  final bool accent;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Row(
      children: [
        Text(label),
        const Spacer(),
        Text(
          formatPhp(amount),
          style: TextStyle(
            color: accent ? Theme.of(context).colorScheme.primary : null,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}
