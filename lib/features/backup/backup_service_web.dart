import '../../core/errors/validation_exception.dart';
import '../../database/app_database.dart';

class BackupService {
  BackupService(AppDatabase database);

  Future<void> shareBackup() async {
    throw const ValidationException(
      'Backup export is unavailable in the browser preview.',
    );
  }

  Future<bool> pickAndRestore() async {
    throw const ValidationException(
      'Backup restore is unavailable in the browser preview.',
    );
  }
}
