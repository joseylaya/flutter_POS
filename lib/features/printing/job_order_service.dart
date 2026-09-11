import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../core/errors/validation_exception.dart';
import '../../database/app_database.dart';

class JobOrderService {
  Future<void> print({
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
    if (!await PrintBluetoothThermal.isPermissionBluetoothGranted) {
      throw const ValidationException(
        'Allow Nearby devices permission to use the Bluetooth printer.',
      );
    }
    if (!await PrintBluetoothThermal.bluetoothEnabled) {
      throw const ValidationException('Turn on Bluetooth, then try again.');
    }
    final connected = await PrintBluetoothThermal.connect(
      macPrinterAddress: address,
    );
    if (!connected) {
      throw const ValidationException('Unable to connect to the printer.');
    }
    if (!await PrintBluetoothThermal.writeBytes(
      await buildBytes(settings: settings, sale: sale, items: items),
    )) {
      throw const ValidationException(
        'The kitchen job order failed to print. You can try again.',
      );
    }
  }

  Future<List<int>> buildBytes({
    required Setting settings,
    required Sale sale,
    required List<SaleItem> items,
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(
      settings.printerPaperWidthMm == 80 ? PaperSize.mm80 : PaperSize.mm58,
      profile,
    );
    final bytes = <int>[0x1B, 0x32];
    bytes.addAll(
      generator.text(
        'KITCHEN JOB ORDER',
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
        'ORDER #${sale.transactionNumber.toString().padLeft(6, '0')}',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size2,
        ),
      ),
    );
    bytes.addAll(
      generator.text(
        sale.orderType == 'DINE_IN'
            ? 'DINE IN'
            : 'TAKE OUT - ${sale.fulfillmentType == 'DELIVERY' ? 'DELIVERY' : 'PICKUP'}',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      ),
    );
    bytes.addAll(
      generator.text(
        _dateTime(sale.completedAt),
        styles: const PosStyles(align: PosAlign.center),
      ),
    );
    bytes.addAll(generator.hr());
    bytes.addAll(const [0x1B, 0x33, 48]);
    for (final item in items) {
      bytes.addAll(
        generator.row([
          PosColumn(
            text: '${item.quantity}x',
            width: 2,
            styles: const PosStyles(bold: true, height: PosTextSize.size2),
          ),
          PosColumn(
            text: item.productName,
            width: 10,
            styles: const PosStyles(bold: true, height: PosTextSize.size2),
          ),
        ]),
      );
    }
    bytes.addAll(const [0x1B, 0x32]);
    bytes.addAll(generator.hr());
    final itemCount = items.fold<int>(0, (sum, item) => sum + item.quantity);
    bytes.addAll(
      generator.text(
        'TOTAL ITEMS: $itemCount',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      ),
    );
    bytes.addAll(generator.feed(2));
    bytes.addAll(const [0x1D, 0x56, 0x30]);
    return bytes;
  }

  String _dateTime(DateTime value) =>
      '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')} '
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}
