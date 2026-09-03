import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../backup/backup_provider.dart';
import '../../printing/receipt_service.dart';
import '../application/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ref
          .watch(settingsProvider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('$error')),
            data: (settings) => ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _Section(
                  title: 'Appearance',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose the most comfortable display for your counter.',
                      ),
                      const SizedBox(height: 12),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(
                            value: 'SYSTEM',
                            icon: Icon(Icons.brightness_auto_outlined),
                            label: Text('System'),
                          ),
                          ButtonSegment(
                            value: 'LIGHT',
                            icon: Icon(Icons.light_mode_outlined),
                            label: Text('Light'),
                          ),
                          ButtonSegment(
                            value: 'DARK',
                            icon: Icon(Icons.dark_mode_outlined),
                            label: Text('Dark'),
                          ),
                        ],
                        selected: {settings.themeMode},
                        onSelectionChanged: (value) => ref
                            .read(settingsRepositoryProvider)
                            .updateThemeMode(value.single),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _Section(
                  title: 'Business & receipt',
                  child: _BusinessForm(
                    name: settings.businessName,
                    footer: settings.receiptFooter,
                  ),
                ),
                const SizedBox(height: 14),
                _Section(
                  title: 'Bluetooth printer',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        settings.printerName == null
                            ? 'No printer selected'
                            : '${settings.printerName} • ${settings.printerPaperWidthMm} mm',
                      ),
                      const SizedBox(height: 10),
                      FilledButton.tonalIcon(
                        onPressed: () => _selectPrinter(
                          context,
                          ref,
                          settings.printerPaperWidthMm,
                        ),
                        icon: const Icon(Icons.bluetooth_searching),
                        label: const Text('Select paired printer'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _Section(
                  title: 'Local backup',
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: () => _export(context, ref),
                        icon: const Icon(Icons.ios_share),
                        label: const Text('Export backup'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _restore(context, ref),
                        icon: const Icon(Icons.restore),
                        label: const Text('Restore backup'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _selectPrinter(
    BuildContext context,
    WidgetRef ref,
    int currentWidth,
  ) async {
    try {
      final printers = await ReceiptService().pairedPrinters();
      if (!context.mounted) return;
      final selected = await showDialog<BluetoothInfo>(
        context: context,
        builder: (_) => SimpleDialog(
          title: const Text('Paired Bluetooth printers'),
          children: printers.isEmpty
              ? [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Pair the printer in Android Bluetooth settings first.',
                    ),
                  ),
                ]
              : printers
                    .map(
                      (printer) => SimpleDialogOption(
                        onPressed: () => Navigator.pop(context, printer),
                        child: Text('${printer.name}\n${printer.macAdress}'),
                      ),
                    )
                    .toList(),
        ),
      );
      if (selected == null || !context.mounted) return;
      final width = await showDialog<int>(
        context: context,
        builder: (_) => SimpleDialog(
          title: const Text('Paper width'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 58),
              child: const Text('58 mm'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 80),
              child: const Text('80 mm'),
            ),
          ],
        ),
      );
      await ref
          .read(settingsRepositoryProvider)
          .updatePrinter(
            name: selected.name,
            address: selected.macAdress,
            width: width ?? currentWidth,
          );
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(backupServiceProvider).shareBackup();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }

  Future<void> _restore(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Restore backup?'),
        content: const Text(
          'The selected valid backup will replace local JmPOS data. A safety copy is retained.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Choose backup'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      if (await ref.read(backupServiceProvider).pickAndRestore()) {
        SystemNavigator.pop();
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

class _BusinessForm extends ConsumerStatefulWidget {
  const _BusinessForm({required this.name, required this.footer});
  final String name;
  final String footer;
  @override
  ConsumerState<_BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends ConsumerState<_BusinessForm> {
  late final name = TextEditingController(text: widget.name);
  late final footer = TextEditingController(text: widget.footer);
  @override
  void dispose() {
    name.dispose();
    footer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextField(
        controller: name,
        decoration: const InputDecoration(labelText: 'Business name'),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: footer,
        decoration: const InputDecoration(labelText: 'Receipt footer'),
      ),
      const SizedBox(height: 10),
      Align(
        alignment: Alignment.centerRight,
        child: FilledButton(
          onPressed: () => ref
              .read(settingsRepositoryProvider)
              .updateBusiness(name: name.text, footer: footer.text),
          child: const Text('Save'),
        ),
      ),
    ],
  );
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    ),
  );
}
