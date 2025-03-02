import 'package:vivebien/domain/datasources/local_storage_datasource.dart';
import 'package:vivebien/domain/entities/reminder.dart';

class IsarDatasource extends LocalStorageDatasource {
  @override
  Future<void> createNewReminder(Reminder reminder) {
    // TODO: implement createNewReminder
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteReminder(int id) {
    // TODO: implement deleteReminder
    throw UnimplementedError();
  }

  @override
  Future<List<Reminder>> getReminder() {
    // TODO: implement getReminder
    throw UnimplementedError();
  }

  @override
  Future<bool> updateReminder(Reminder reminder) {
    // TODO: implement updateReminder
    throw UnimplementedError();
  }
}
