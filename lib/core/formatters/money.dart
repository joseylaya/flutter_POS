import '../errors/validation_exception.dart';

String formatPhp(int centavos) {
  final absolute = centavos.abs();
  final pesos = absolute ~/ 100;
  final cents = (absolute % 100).toString().padLeft(2, '0');
  final grouped = pesos.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
  return '${centavos < 0 ? '-' : ''}₱$grouped.$cents';
}

int parsePhp(String input) {
  final normalized = input.trim().replaceAll(',', '').replaceAll('₱', '');
  if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(normalized)) {
    throw const ValidationException(
      'Enter a valid amount with up to 2 decimal places.',
    );
  }
  final parts = normalized.split('.');
  final pesos = int.parse(parts.first);
  final centavos = parts.length == 1
      ? 0
      : int.parse(parts.last.padRight(2, '0'));
  return pesos * 100 + centavos;
}
