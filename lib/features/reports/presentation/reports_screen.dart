import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatters/money.dart';
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
                          (sale) => Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: const Icon(Icons.receipt_long),
                              title: Text(
                                '#${sale.transactionNumber.toString().padLeft(6, '0')} • ${formatPhp(sale.totalAmount)}',
                              ),
                              subtitle: Text(
                                '${sale.paymentMethod}${sale.paymentReference == null ? '' : ' • Ref ${sale.paymentReference}'} • ${sale.completedAt}',
                              ),
                              trailing: IconButton(
                                tooltip: 'Print receipt',
                                icon: const Icon(Icons.print_outlined),
                                onPressed: () => _print(context, ref, sale.id),
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
          .firstWhere((item) => item.id == saleId);
      final items = await ref.read(reportsRepositoryProvider).saleItems(saleId);
      final settings = await ref.read(settingsRepositoryProvider).get();
      await ReceiptService().printReceipt(
        settings: settings,
        sale: sale,
        items: items,
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
