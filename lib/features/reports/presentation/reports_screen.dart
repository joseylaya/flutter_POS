import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatters/money.dart';
import '../../../core/errors/validation_exception.dart';
import '../../../core/services/app_haptics.dart';
import '../../printing/receipt_service.dart';
import '../../settings/application/settings_providers.dart';
import '../application/report_providers.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  ReportPeriod period = ReportPeriod.today;

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(reportSummaryProvider(period));
    final performance = ref.watch(productPerformanceProvider(period));
    final sales = ref.watch(salesHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Sales & Reports')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SegmentedButton<ReportPeriod>(
            segments: const [
              ButtonSegment(value: ReportPeriod.today, label: Text('Today')),
              ButtonSegment(value: ReportPeriod.week, label: Text('This week')),
              ButtonSegment(
                value: ReportPeriod.month,
                label: Text('This month'),
              ),
            ],
            selected: {period},
            onSelectionChanged: (value) =>
                setState(() => period = value.single),
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
                    children: items
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
                        )
                        .toList(),
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
            data: (items) => items.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(child: Text('No completed sales yet.')),
                  )
                : Column(
                    children: items
                        .map(
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
                                    _print(context, ref, entry.sale.id);
                                  } else {
                                    _reverse(
                                      context,
                                      ref,
                                      entry.sale.id,
                                      action,
                                    );
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
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _print(
    BuildContext context,
    WidgetRef ref,
    String saleId,
  ) async {
    try {
      await AppHaptics.medium();
      final sale = ref
          .read(salesHistoryProvider)
          .valueOrNull!
          .firstWhere((item) => item.sale.id == saleId)
          .sale;
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
