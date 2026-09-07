import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import '../../core/errors/validation_exception.dart';
import '../../database/app_database.dart';

class BackupService {
  BackupService(this._database);
  final AppDatabase _database;
  static const _channel = MethodChannel('com.jmpos.jm_pos/backup');

  Future<File> createBackup() async {
    final path = await _channel.invokeMethod<String>('create');
    if (path == null) {
      throw const ValidationException('Unable to create the encrypted backup.');
    }
    return File(path);
  }

  Future<void> shareBackup() async {
    final file = await createBackup();
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/octet-stream')],
        subject: 'JmPOS encrypted backup',
      ),
    );
  }

  Future<bool> pickAndRestore({required String password}) async {
    final result = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['jmpos'],
    );
    final selectedPath = result?.path;
    if (selectedPath == null) return false;
    final decryptedPath = await _channel.invokeMethod<String>('decrypt', {
      'path': selectedPath,
      'password': password,
    });
    if (decryptedPath == null) {
      throw const ValidationException('Unable to decrypt the backup.');
    }
    await restore(File(decryptedPath));
    return true;
  }

  Future<BackupStatus> status() async {
    final result = await _channel.invokeMapMethod<Object?, Object?>('status');
    return BackupStatus.fromMap(result ?? const {});
  }

  Future<BackupStatus> configure(String password) async {
    final result = await _channel.invokeMapMethod<Object?, Object?>(
      'configure',
      {'password': password},
    );
    return BackupStatus.fromMap(result ?? const {});
  }

  Future<BackupStatus> backupNow() async {
    final result = await _channel.invokeMapMethod<Object?, Object?>(
      'backupNow',
    );
    return BackupStatus.fromMap(result ?? const {});
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

class BackupStatus {
  const BackupStatus({
    required this.configured,
    required this.folder,
    required this.schedule,
    this.lastBackupAt,
  });

  final bool configured;
  final String folder;
  final String schedule;
  final DateTime? lastBackupAt;

  factory BackupStatus.fromMap(Map<Object?, Object?> value) {
    final millis = value['lastBackupAt'] as int?;
    return BackupStatus(
      configured: value['configured'] == true,
      folder: value['folder'] as String? ?? 'Downloads/JmPOS/database-backup',
      schedule: value['schedule'] as String? ?? '10:00 AM, 3:00 PM, 10:00 PM',
      lastBackupAt: millis == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(millis),
    );
  }
}
