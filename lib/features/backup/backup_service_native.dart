import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import '../../core/errors/validation_exception.dart';
import '../../database/app_database.dart';

class BackupService {
  BackupService(this._database);
  final AppDatabase _database;

  Future<File> createBackup() async {
    final temporary = await getTemporaryDirectory();
    final stamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final file = File(p.join(temporary.path, 'jmpos-backup-$stamp.sqlite'));
    if (await file.exists()) await file.delete();
    final escaped = file.path.replaceAll("'", "''");
    await _database.customStatement("VACUUM INTO '$escaped'");
    return file;
  }

  Future<void> shareBackup() async {
    final file = await createBackup();
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/vnd.sqlite3')],
        subject: 'JmPOS local backup',
      ),
    );
  }

  Future<bool> pickAndRestore() async {
    final result = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['sqlite', 'db'],
    );
    final selectedPath = result?.path;
    if (selectedPath == null) return false;
    await restore(File(selectedPath));
    return true;
  }

  Future<void> restore(File candidate) async {
    _validate(candidate);
    final documents = await getApplicationDocumentsDirectory();
    final active = File(p.join(documents.path, 'jm_pos.sqlite'));
    final safety = File(p.join(documents.path, 'jm_pos.pre-restore.sqlite'));
    await _database.close();
    try {
      if (await safety.exists()) await safety.delete();
      if (await active.exists()) await active.copy(safety.path);
      await candidate.copy(active.path);
    } catch (_) {
      if (await safety.exists()) await safety.copy(active.path);
      rethrow;
    }
  }

  void _validate(File candidate) {
    if (!candidate.existsSync()) {
      throw const ValidationException('Backup file does not exist.');
    }
    sqlite.Database? db;
    try {
      db = sqlite.sqlite3.open(candidate.path, mode: sqlite.OpenMode.readOnly);
      final integrity = db.select('PRAGMA integrity_check').first.values.first;
      if (integrity != 'ok') {
        throw const ValidationException('Backup integrity check failed.');
      }
      final names = db
          .select("SELECT name FROM sqlite_master WHERE type='table'")
          .map((row) => row['name'])
          .toSet();
      const required = {
        'settings',
        'products',
        'inventory_items',
        'inventory_movements',
        'discounts',
        'discount_products',
        'sales',
        'sale_items',
        'expenses',
      };
      if (!names.containsAll(required)) {
        throw const ValidationException(
          'This is not a compatible JmPOS backup.',
        );
      }
    } on ValidationException {
      rethrow;
    } catch (_) {
      throw const ValidationException(
        'The selected backup is invalid or unreadable.',
      );
    } finally {
      db?.close();
    }
  }
}
