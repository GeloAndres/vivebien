import 'package:vivebien/domain/entities/reminder.dart';

abstract class CloudStorageRepository {
  Future<void> synchronizeData();
  Future<bool> createReminder(Reminder reminder);
  Future<bool> deleteReminder(String id);
  Future<bool> updateReminder(Reminder reminder);
}
