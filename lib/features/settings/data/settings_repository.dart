import 'package:drift/drift.dart';

import '../../../database/app_database.dart';

class SettingsRepository {
  SettingsRepository(this._database);
  final AppDatabase _database;

  Stream<Setting> watch() => _database.select(_database.settings).watchSingle();
  Future<Setting> get() => _database.select(_database.settings).getSingle();

  Future<void> updateBusiness({
    required String name,
    required String tagline,
    required String hours,
    required String address,
    required String footer,
  }) async {
    await _database
        .update(_database.settings)
        .write(
          SettingsCompanion(
            businessName: Value(
              name.trim().isEmpty ? 'BRADZ SILOGAN' : name.trim(),
            ),
            receiptTagline: Value(tagline.trim()),
            businessHours: Value(hours.trim()),
            businessAddress: Value(address.trim()),
            receiptFooter: Value(footer.trim()),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<void> updatePrinter({
    required String? name,
    required String? address,
    required int width,
  }) async {
    await _database
        .update(_database.settings)
        .write(
          SettingsCompanion(
            printerName: Value(name),
            printerAddress: Value(address),
            printerPaperWidthMm: Value(width),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<void> updateThemeMode(String mode) async {
    await _database
        .update(_database.settings)
        .write(
          SettingsCompanion(
            themeMode: Value(mode),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }
}
