import 'package:vivebien/domain/datasources/local_storage_datasource.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl({required this.datasource});

  @override
  Future<bool> createNewReminder(Reminder reminder) {
    return datasource.createNewReminder(reminder);
  }

  @override
  Future<bool> deleteReminder(int id) {
    return datasource.deleteReminder(id);
  }

  @override
  Future<List<Reminder>> getReminder() {
    return datasource.getReminder();
  }

  @override
  Future<bool> updateReminder(Reminder reminder) {
    return datasource.updateReminder(reminder);
  }
}
