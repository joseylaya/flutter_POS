import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../core/errors/validation_exception.dart';
import '../../core/formatters/money.dart';
import '../../database/app_database.dart';

class ReceiptService {
  Future<List<BluetoothInfo>> pairedPrinters() =>
      PrintBluetoothThermal.pairedBluetooths;

  Future<void> printReceipt({
    required Setting settings,
    required Sale sale,
    required List<SaleItem> items,
  }) async {
    final address = settings.printerAddress;
    if (address == null || address.isEmpty) {
      throw const ValidationException(
        'Select a Bluetooth printer in Settings.',
      );
    }
    final connected = await PrintBluetoothThermal.connect(
      macPrinterAddress: address,
    );
    if (!connected) {
      throw const ValidationException('Unable to connect to the printer.');
    }
    final bytes = await buildReceiptBytes(
      settings: settings,
      sale: sale,
      items: items,
    );
    if (!await PrintBluetoothThermal.writeBytes(bytes)) {
      throw const ValidationException(
        'Receipt failed to print. The sale remains completed.',
      );
    }
  }

  Future<List<int>> buildReceiptBytes({
    required Setting settings,
    required Sale sale,
    required List<SaleItem> items,
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(
      settings.printerPaperWidthMm == 80 ? PaperSize.mm80 : PaperSize.mm58,
      profile,
    );
    final bytes = <int>[];
    bytes.addAll(
      generator.text(
        settings.businessName,
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
    );
    bytes.addAll(
      generator.text(
        _dateTime(sale.completedAt),
        styles: const PosStyles(align: PosAlign.center),
      ),
    );
    bytes.addAll(
      generator.text(
        'Transaction #${sale.transactionNumber.toString().padLeft(6, '0')}',
        styles: const PosStyles(align: PosAlign.center),
      ),
    );
    bytes.addAll(generator.hr());
    for (final item in items) {
      bytes.addAll(generator.text('${item.productName} x${item.quantity}'));
      bytes.addAll(
        generator.text(
          _receiptMoney(item.lineTotal),
          styles: const PosStyles(align: PosAlign.right),
        ),
      );
    }
    bytes.addAll(generator.hr());
    bytes.addAll(
      generator.row([
        PosColumn(text: 'Subtotal', width: 6),
        PosColumn(
          text: _receiptMoney(sale.subtotal),
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]),
    );
    if (sale.discountAmount > 0) {
      bytes.addAll(
        generator.row([
          PosColumn(text: 'Discount', width: 6),
          PosColumn(
            text: '-${_receiptMoney(sale.discountAmount)}',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]),
      );
    }
    bytes.addAll(
      generator.row([
        PosColumn(text: 'TOTAL', width: 6, styles: const PosStyles(bold: true)),
        PosColumn(
          text: _receiptMoney(sale.totalAmount),
          width: 6,
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
      ]),
    );
    bytes.addAll(generator.text('Payment: ${sale.paymentMethod}'));
    if (sale.paymentReference != null) {
      bytes.addAll(generator.text('Reference: ${sale.paymentReference}'));
    }
    if (sale.paymentMethod == 'CASH') {
      bytes.addAll(
        generator.text('Cash: ${_receiptMoney(sale.cashReceived!)}'),
      );
      bytes.addAll(
        generator.text('Change: ${_receiptMoney(sale.changeAmount!)}'),
      );
    }
    bytes.addAll(generator.feed(1));
    bytes.addAll(
      generator.text(
        settings.receiptFooter,
        styles: const PosStyles(align: PosAlign.center),
      ),
    );
    bytes.addAll(generator.feed(2));
    bytes.addAll(generator.cut());
    return bytes;
  }

  String _dateTime(DateTime value) =>
      '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')} '
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  String _receiptMoney(int centavos) =>
      formatPhp(centavos).replaceFirst('₱', 'PHP ');
}
