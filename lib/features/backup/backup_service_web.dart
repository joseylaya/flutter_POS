import '../../core/errors/validation_exception.dart';
import '../../database/app_database.dart';

class BackupService {
  BackupService(AppDatabase database);

  Future<void> shareBackup() async {
    throw const ValidationException(
      'Backup export is unavailable in the browser preview.',
    );
  }

  Future<bool> pickAndRestore({required String password}) async {
    throw const ValidationException(
      'Backup restore is unavailable in the browser preview.',
    );
  }

  Future<BackupStatus> status() async => const BackupStatus(
    configured: false,
    folder: 'Unavailable in browser',
    schedule: 'Unavailable in browser',
  );

  Future<BackupStatus> configure(String password) async {
    throw const ValidationException(
      'Scheduled backup is unavailable in the browser preview.',
    );
  }

  Future<BackupStatus> backupNow() async {
    throw const ValidationException(
      'Scheduled backup is unavailable in the browser preview.',
    );
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
}
