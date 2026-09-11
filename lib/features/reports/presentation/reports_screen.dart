import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatters/money.dart';
import '../../../core/errors/validation_exception.dart';
import '../../../core/services/app_haptics.dart';
import '../../../database/app_database.dart';
import '../../printing/receipt_service.dart';
import '../../settings/application/settings_providers.dart';
import '../application/report_providers.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  static const int _transactionPageSize = 10;
  late DateTime fromMonth;
  late DateTime toMonth;
  int transactionPage = 0;
  bool showAllProducts = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    fromMonth = DateTime(now.year, now.month);
    toMonth = DateTime(now.year, now.month);
  }

  @override
  Widget build(BuildContext context) {
    final range = (
      from: fromMonth,
      until: DateTime(toMonth.year, toMonth.month + 1),
    );
    final summary = ref.watch(reportSummaryProvider(range));
    final performance = ref.watch(productPerformanceProvider(range));
    final sales = ref.watch(
      salesHistoryPageProvider((
        page: transactionPage,
        pageSize: _transactionPageSize,
        from: range.from,
        until: range.until,
      )),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Sales & Reports')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _RangeSelector(
            from: fromMonth,
            to: toMonth,
            onFrom: () => _pickMonth(isFrom: true),
            onTo: () => _pickMonth(isFrom: false),
          ),
          const SizedBox(height: 12),
          summary.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('Unable to load totals: $error'),
            data: (value) => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _Metric('Sales', formatPhp(value.sales)),
                _Metric('Product cost', formatPhp(value.cost)),
                _Metric('Gross profit', formatPhp(value.grossProfit)),
                _Metric('Expenses', formatPhp(value.expenses)),
                _Metric('Net profit', formatPhp(value.netProfit)),
                _Metric('Orders', '${value.orders}'),
                _Metric('Items sold', '${value.itemsSold}'),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Product performance',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          performance.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
            data: (items) => items.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No product sales for this period.'),
                  )
                : Column(
                    children: [
                      ...items
                          .take(showAllProducts ? items.length : 5)
                          .map(
                            (item) => ListTile(
                              title: Text(item.productName),
                              subtitle: Text(
                                '${item.quantity} sold • Profit ${formatPhp(item.profit)}',
                              ),
                              trailing: Text(
                                formatPhp(item.revenue),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                      if (items.length > 5)
                        TextButton.icon(
                          onPressed: () => setState(
                            () => showAllProducts = !showAllProducts,
                          ),
                          icon: Icon(
                            showAllProducts
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                          label: Text(
                            showAllProducts
                                ? 'Show fewer products'
                                : 'Show ${items.length - 5} more products',
                          ),
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 28),
          Text(
            'Transactions',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          sales.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('Unable to load transactions: $error'),
            data: (page) => page.items.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(child: Text('No completed sales yet.')),
                  )
                : Column(
                    children: [
                      ...page.items.map(
                        (entry) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Icon(
                              entry.isReversed
                                  ? Icons.undo
                                  : Icons.receipt_long,
                              color: entry.isReversed
                                  ? Theme.of(context).colorScheme.error
                                  : null,
                            ),
                            title: Text(
                              '#${entry.sale.transactionNumber.toString().padLeft(6, '0')} • ${formatPhp(entry.sale.totalAmount)}',
                              style: TextStyle(
                                decoration: entry.isReversed
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Text(
                              '${entry.isReversed ? '${entry.reversal!.reversalType == 'REFUND' ? 'REFUNDED' : 'CANCELLED'} • ${entry.reversal!.reason}\n' : ''}${entry.sale.orderType == 'DINE_IN' ? 'Dine in' : 'Take out • ${entry.sale.fulfillmentType == 'DELIVERY' ? 'Delivery' : 'Pickup'}'} • ${entry.sale.paymentMethod}${entry.sale.paymentReference == null ? '' : ' • Ref ${entry.sale.paymentReference}'} • ${entry.sale.completedAt}',
                            ),
                            isThreeLine: entry.isReversed,
                            trailing: PopupMenuButton<String>(
                              tooltip: 'Transaction actions',
                              onSelected: (action) {
                                if (action == 'REPRINT') {
                                  _print(
                                    context,
                                    ref,
                                    entry.sale.id,
                                    entry.sale,
                                  );
                                } else {
                                  _reverse(context, ref, entry.sale.id, action);
                                }
                              },
                              itemBuilder: (_) => [
                                const PopupMenuItem(
                                  value: 'REPRINT',
                                  child: ListTile(
                                    leading: Icon(Icons.print_outlined),
                                    title: Text('Reprint receipt'),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                if (!entry.isReversed) ...[
                                  const PopupMenuDivider(),
                                  const PopupMenuItem(
                                    value: 'CANCELLATION',
                                    child: ListTile(
                                      leading: Icon(Icons.cancel_outlined),
                                      title: Text('Cancel sale'),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'REFUND',
                                    child: ListTile(
                                      leading: Icon(Icons.currency_exchange),
                                      title: Text('Refund sale'),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (transactionPage > 0 || page.hasNext)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                onPressed: transactionPage == 0
                                    ? null
                                    : () => setState(() => transactionPage--),
                                icon: const Icon(Icons.chevron_left),
                                label: const Text('Previous'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                                child: Text(
                                  'Page ${transactionPage + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: page.hasNext
                                    ? () => setState(() => transactionPage++)
                                    : null,
                                iconAlignment: IconAlignment.end,
                                icon: const Icon(Icons.chevron_right),
                                label: const Text('Next'),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickMonth({required bool isFrom}) async {
    final selected = await showDialog<DateTime>(
      context: context,
      builder: (_) => _MonthYearDialog(initial: isFrom ? fromMonth : toMonth),
    );
    if (selected == null) return;
    setState(() {
      if (isFrom) {
        fromMonth = selected;
        if (fromMonth.isAfter(toMonth)) toMonth = fromMonth;
      } else {
        toMonth = selected;
        if (toMonth.isBefore(fromMonth)) fromMonth = toMonth;
      }
      transactionPage = 0;
      showAllProducts = false;
    });
  }

  Future<void> _print(
    BuildContext context,
    WidgetRef ref,
    String saleId,
    Sale sale,
  ) async {
    try {
      await AppHaptics.medium();
      final items = await ref.read(reportsRepositoryProvider).saleItems(saleId);
      final settings = await ref.read(settingsRepositoryProvider).get();
      await ReceiptService().printReceipt(
        settings: settings,
        sale: sale,
        items: items,
        isReprint: true,
      );
      await AppHaptics.light();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Receipt printed.')));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }

  Future<void> _reverse(
    BuildContext context,
    WidgetRef ref,
    String saleId,
    String reversalType,
  ) async {
    final label = reversalType == 'REFUND' ? 'Refund' : 'Cancel';
    final reason = TextEditingController();
    String? error;
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('$label sale'),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'This restores all product and inclusion stock and removes the sale from revenue reports. The audit record cannot be reversed.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: reason,
                  autofocus: true,
                  maxLength: 250,
                  minLines: 2,
                  maxLines: 4,
                  onChanged: (_) => setDialogState(() => error = null),
                  decoration: InputDecoration(
                    labelText: 'Reason',
                    hintText: reversalType == 'REFUND'
                        ? 'Example: Customer returned the order'
                        : 'Example: Duplicate order',
                    errorText: error,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Keep sale'),
            ),
            FilledButton(
              onPressed: () {
                if (reason.text.trim().length < 3) {
                  setDialogState(() => error = 'Enter at least 3 characters.');
                  return;
                }
                Navigator.pop(dialogContext, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text('$label and restore stock'),
            ),
          ],
        ),
      ),
    );
    if (confirmed != true) {
      reason.dispose();
      return;
    }
    try {
      await ref
          .read(reportsRepositoryProvider)
          .reverseSale(
            saleId: saleId,
            reversalType: reversalType,
            reason: reason.text,
          );
      await AppHaptics.success();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label completed and stock restored.')),
        );
      }
    } on ValidationException catch (exception) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(exception.message)));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to reverse the sale. Nothing was changed.'),
          ),
        );
      }
    } finally {
      reason.dispose();
    }
  }
}

class _RangeSelector extends StatelessWidget {
  const _RangeSelector({
    required this.from,
    required this.to,
    required this.onFrom,
    required this.onTo,
  });

  final DateTime from;
  final DateTime to;
  final VoidCallback onFrom;
  final VoidCallback onTo;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.date_range_outlined),
              SizedBox(width: 8),
              Text(
                'Report range',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _MonthButton(label: 'From', value: from, onPressed: onFrom),
              const Icon(Icons.arrow_forward, size: 20),
              _MonthButton(label: 'Through', value: to, onPressed: onTo),
              Text(
                _rangeDescription(from, to),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _MonthButton extends StatelessWidget {
  const _MonthButton({
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final String label;
  final DateTime value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: const Icon(Icons.calendar_month_outlined),
    label: Text('$label: ${_monthName(value.month)} ${value.year}'),
  );
}

class _MonthYearDialog extends StatefulWidget {
  const _MonthYearDialog({required this.initial});

  final DateTime initial;

  @override
  State<_MonthYearDialog> createState() => _MonthYearDialogState();
}

class _MonthYearDialogState extends State<_MonthYearDialog> {
  late int month;
  late int year;

  @override
  void initState() {
    super.initState();
    month = widget.initial.month;
    year = widget.initial.year;
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    return AlertDialog(
      title: const Text('Choose month and year'),
      content: SizedBox(
        width: 360,
        child: Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: month,
                decoration: const InputDecoration(labelText: 'Month'),
                items: [
                  for (var value = 1; value <= 12; value++)
                    DropdownMenuItem(
                      value: value,
                      child: Text(_monthName(value)),
                    ),
                ],
                onChanged: (value) => setState(() => month = value!),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 130,
              child: DropdownButtonFormField<int>(
                initialValue: year,
                decoration: const InputDecoration(labelText: 'Year'),
                items: [
                  for (var value = currentYear + 1; value >= 2016; value--)
                    DropdownMenuItem(value: value, child: Text('$value')),
                ],
                onChanged: (value) => setState(() => year = value!),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, DateTime(year, month)),
          child: const Text('Use month'),
        ),
      ],
    );
  }
}

const _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

String _monthName(int month) => _monthNames[month - 1];

String _rangeDescription(DateTime from, DateTime to) {
  final months = (to.year - from.year) * 12 + to.month - from.month + 1;
  return months == 1 ? '1 month overview' : '$months month overview';
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 170,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ),
  );
}
