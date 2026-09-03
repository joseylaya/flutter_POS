import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatters/money.dart';
import '../application/expense_providers.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (_) => const _ExpenseDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add expense'),
      ),
      body: expenses.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (items) => items.isEmpty
            ? const Center(child: Text('No operating expenses recorded.'))
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text(
                        '${item.category} • ${item.expenseDate.year}-${item.expenseDate.month}-${item.expenseDate.day}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            formatPhp(item.amount),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          IconButton(
                            onPressed: () => ref
                                .read(expenseRepositoryProvider)
                                .delete(item.id),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _ExpenseDialog extends ConsumerStatefulWidget {
  const _ExpenseDialog();
  @override
  ConsumerState<_ExpenseDialog> createState() => _ExpenseDialogState();
}

class _ExpenseDialogState extends ConsumerState<_ExpenseDialog> {
  final name = TextEditingController();
  final category = TextEditingController(text: 'Other');
  final amount = TextEditingController();
  final notes = TextEditingController();
  String? error;

  @override
  void dispose() {
    for (final value in [name, category, amount, notes]) {
      value.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Add expense'),
    content: SizedBox(
      width: 450,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: category,
            decoration: const InputDecoration(labelText: 'Category'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: amount,
            decoration: const InputDecoration(
              labelText: 'Amount',
              prefixText: '₱',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: notes,
            decoration: const InputDecoration(labelText: 'Notes (optional)'),
          ),
          if (error != null)
            Text(
              error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(onPressed: _save, child: const Text('Save')),
    ],
  );

  Future<void> _save() async {
    try {
      await ref
          .read(expenseRepositoryProvider)
          .add(
            name: name.text,
            category: category.text,
            amount: parsePhp(amount.text),
            date: DateTime.now(),
            notes: notes.text,
          );
      if (mounted) Navigator.pop(context);
    } catch (value) {
      setState(() => error = '$value');
    }
  }
}
