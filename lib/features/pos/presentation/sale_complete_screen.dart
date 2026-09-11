import 'package:flutter/material.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../core/services/app_haptics.dart';
import '../../../database/app_database.dart';
import '../../printing/job_order_service.dart';

class SaleCompleteScreen extends StatefulWidget {
  const SaleCompleteScreen({
    super.key,
    required this.sale,
    required this.items,
    required this.settings,
    required this.receiptMessage,
  });

  final Sale sale;
  final List<SaleItem> items;
  final Setting settings;
  final String receiptMessage;

  @override
  State<SaleCompleteScreen> createState() => _SaleCompleteScreenState();
}

class _SaleCompleteScreenState extends State<SaleCompleteScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  bool printing = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ScaleTransition(
                  scale: _scale,
                  child: Center(
                    child: Container(
                      width: 116,
                      height: 116,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 76,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Sale completed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Order #${widget.sale.transactionNumber.toString().padLeft(6, '0')} is paid and saved.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.receiptMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 28),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(Icons.soup_kitchen_outlined, size: 38),
                        const SizedBox(height: 10),
                        const Text(
                          'Send order to the kitchen',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${widget.items.fold<int>(0, (sum, item) => sum + item.quantity)} items will print without prices.',
                          textAlign: TextAlign.center,
                        ),
                        if (error != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            error!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                        const SizedBox(height: 18),
                        FilledButton.icon(
                          key: const Key('print-job-order'),
                          onPressed: printing ? null : _printJobOrder,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(58),
                          ),
                          icon: printing
                              ? const SizedBox.square(
                                  dimension: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Icon(Icons.print_outlined),
                          label: Text(
                            printing
                                ? 'Printing job order…'
                                : 'Print Job Order',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                TextButton(
                  key: const Key('skip-job-order'),
                  onPressed: printing ? null : _returnHome,
                  child: const Text('Skip'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Future<void> _printJobOrder() async {
    await AppHaptics.medium();
    setState(() {
      printing = true;
      error = null;
    });
    try {
      await JobOrderService().print(
        settings: widget.settings,
        sale: widget.sale,
        items: widget.items,
      );
      await AppHaptics.success();
      if (mounted) _returnHome();
    } on ValidationException catch (exception) {
      if (mounted) setState(() => error = exception.message);
    } catch (_) {
      if (mounted) {
        setState(() => error = 'Unable to print the kitchen job order.');
      }
    } finally {
      if (mounted) setState(() => printing = false);
    }
  }

  void _returnHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
