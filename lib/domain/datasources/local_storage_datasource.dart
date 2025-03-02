import 'package:vivebien/domain/entities/reminder.dart';

abstract class LocalStorageDatasource {
  Future<void> createNewReminder(Reminder reminder);
  Future<bool> deleteReminder(int id);
  Future<bool> updateReminder(Reminder reminder);

  Future<List<Reminder>> getReminder();
}
