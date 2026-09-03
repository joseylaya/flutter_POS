import 'package:flutter_test/flutter_test.dart';
import 'package:jm_pos/core/errors/validation_exception.dart';
import 'package:jm_pos/core/formatters/money.dart';

void main() {
  test('formats integer centavos as Philippine pesos', () {
    expect(formatPhp(0), '₱0.00');
    expect(formatPhp(12550), '₱125.50');
    expect(formatPhp(123456789), '₱1,234,567.89');
    expect(formatPhp(-250), '-₱2.50');
  });

  test('parses peso input without floating-point arithmetic', () {
    expect(parsePhp('125'), 12500);
    expect(parsePhp('₱1,250.5'), 125050);
    expect(parsePhp('0.01'), 1);
  });

  test('rejects invalid precision', () {
    expect(() => parsePhp('12.345'), throwsA(isA<ValidationException>()));
    expect(() => parsePhp('-1'), throwsA(isA<ValidationException>()));
  });
}
