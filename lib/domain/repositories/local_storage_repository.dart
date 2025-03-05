import 'package:vivebien/domain/entities/reminder.dart';

abstract class LocalStorageRepository {
  Future<bool> createNewReminder(Reminder reminder);
  Future<bool> deleteReminder(int id);
  Future<bool> updateReminder(Reminder reminder);
  Future<List<Reminder>> getReminder();
  Future<Reminder?> getReminderById(int id);
}
