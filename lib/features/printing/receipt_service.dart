import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../core/errors/validation_exception.dart';
import '../../core/formatters/money.dart';
import '../../database/app_database.dart';

class ReceiptService {
  Future<void> _ensureBluetoothReady() async {
    final permissionGranted =
        await PrintBluetoothThermal.isPermissionBluetoothGranted;
    if (!permissionGranted) {
      throw const ValidationException(
        'Allow Nearby devices permission to use the Bluetooth printer.',
      );
    }
    if (!await PrintBluetoothThermal.bluetoothEnabled) {
      throw const ValidationException('Turn on Bluetooth, then try again.');
    }
  }

  Future<List<BluetoothInfo>> pairedPrinters() async {
    await _ensureBluetoothReady();
    return PrintBluetoothThermal.pairedBluetooths;
  }

  Future<void> printReceipt({
    required Setting settings,
    required Sale sale,
    required List<SaleItem> items,
    bool isReprint = false,
  }) async {
    final address = settings.printerAddress;
    if (address == null || address.isEmpty) {
      throw const ValidationException(
        'Select a Bluetooth printer in Settings.',
      );
    }
    await _ensureBluetoothReady();
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
      isReprint: isReprint,
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
    bool isReprint = false,
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(
      settings.printerPaperWidthMm == 80 ? PaperSize.mm80 : PaperSize.mm58,
      profile,
    );
    final bytes = <int>[];
    if (isReprint) {
      bytes.addAll(
        generator.text(
          'REPRINT',
          styles: const PosStyles(align: PosAlign.center, bold: true),
        ),
      );
    }
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
    bytes.addAll(
      generator.text(
        sale.orderType == 'DINE_IN'
            ? 'Order: Dine in'
            : 'Order: Take out - ${sale.fulfillmentType == 'DELIVERY' ? 'Delivery' : 'Pickup'}',
      ),
    );
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
