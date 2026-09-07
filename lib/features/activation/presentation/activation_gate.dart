import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/services/activation_service.dart';

class ActivationGate extends StatefulWidget {
  const ActivationGate({super.key, required this.child});

  final Widget child;

  @override
  State<ActivationGate> createState() => _ActivationGateState();
}

class _ActivationGateState extends State<ActivationGate> {
  final _service = ActivationService();
  final _code = TextEditingController();
  late Future<ActivationStatus> _status;
  bool _activating = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _status = _service.status();
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<ActivationStatus>(
    future: _status,
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (snapshot.hasError) {
        return _UnavailablePage(onRetry: _reload);
      }
      final status = snapshot.data!;
      if (status.activated) return widget.child;
      return _activationPage(status);
    },
  );

  Widget _activationPage(ActivationStatus status) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.verified_user_outlined, size: 54),
                    const SizedBox(height: 14),
                    Text(
                      'Activate JmPOS',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Send the six-digit Request PIN to the developer, then enter the six-digit Activation PIN you receive. No internet connection is required.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'REQUEST PIN',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SelectableText(
                              status.requestPin ?? '------',
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Copy Request PIN',
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(text: status.requestPin ?? ''),
                              );
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Request PIN copied.'),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.copy),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _code,
                      enabled: !_activating,
                      maxLines: 1,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: (_) => setState(() => _error = null),
                      decoration: InputDecoration(
                        labelText: 'Activation PIN',
                        hintText: 'Enter the six-digit PIN',
                        errorText: _error,
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _activating ? null : _activate,
                      icon: const Icon(Icons.lock_open),
                      label: Text(
                        _activating ? 'Verifying…' : 'Activate offline',
                      ),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(58),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Five incorrect attempts trigger a five-minute cooldown.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Future<void> _activate() async {
    final pin = _code.text.trim();
    if (!RegExp(r'^\d{6}$').hasMatch(pin)) {
      setState(() => _error = 'Enter all six digits.');
      return;
    }
    setState(() {
      _activating = true;
      _error = null;
    });
    try {
      final activated = await _service.activate(pin);
      if (!activated.activated) throw StateError('Activation failed.');
      if (mounted) setState(() => _status = Future.value(activated));
    } on PlatformException catch (error) {
      if (mounted) {
        setState(() => _error = error.message ?? 'Invalid activation PIN.');
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'Unable to verify the activation code.');
      }
    } finally {
      if (mounted) setState(() => _activating = false);
    }
  }

  void _reload() => setState(() => _status = _service.status());
}

class _UnavailablePage extends StatelessWidget {
  const _UnavailablePage({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            const Text('Activation service is unavailable.'),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    ),
  );
}
