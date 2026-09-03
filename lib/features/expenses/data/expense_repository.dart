import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/validation_exception.dart';
import '../../../database/app_database.dart';

class ExpenseRepository {
  ExpenseRepository(this._database, {String Function()? generateId})
    : _generateId = generateId ?? const Uuid().v4;
  final AppDatabase _database;
  final String Function() _generateId;

  Stream<List<Expense>> watchAll() => (_database.select(
    _database.expenses,
  )..orderBy([(t) => OrderingTerm.desc(t.expenseDate)])).watch();

  Future<void> add({
    required String name,
    required String category,
    required int amount,
    required DateTime date,
    String? notes,
  }) async {
    if (name.trim().isEmpty || category.trim().isEmpty || amount <= 0) {
      throw const ValidationException(
        'Name, category, and a positive amount are required.',
      );
    }
    await _database
        .into(_database.expenses)
        .insert(
          ExpensesCompanion.insert(
            id: _generateId(),
            name: name.trim(),
            category: category.trim(),
            amount: amount,
            expenseDate: date,
            notes: Value(notes?.trim().isEmpty == true ? null : notes?.trim()),
          ),
        );
  }

  Future<void> delete(String id) => (_database.delete(
    _database.expenses,
  )..where((t) => t.id.equals(id))).go();
}
