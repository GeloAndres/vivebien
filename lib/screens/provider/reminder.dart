import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/domain/repositories/cloud_storage_repository.dart';
import 'package:vivebien/domain/repositories/local_storage_repository.dart';
import 'package:vivebien/screens/provider/cloudStorageProvider.dart';
import 'package:vivebien/screens/provider/localStorageProvider.dart';

final askReminderProvider =
    StateNotifierProvider<ReminderProvider, List<Reminder>>((ref) {
  final localDatasource = ref.read(localStorageDatasourceProvider);
  final cloudDatasource = ref.read(cloudStorageDatasourceProvider);

  return ReminderProvider(
      localDatasource: localDatasource, cloudDatasource: cloudDatasource);
});

class ReminderProvider extends StateNotifier<List<Reminder>> {
  final LocalStorageRepository localDatasource;
  final CloudStorageRepository cloudDatasource;

  ReminderProvider(
      {required this.localDatasource, required this.cloudDatasource})
      : super([]) {
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final reminders = await localDatasource.getReminder();
    state = reminders;
  }

  Future<void> addReminder(Reminder newReminder) async {
    await localDatasource.createNewReminder(newReminder);
    await cloudDatasource.createReminder(newReminder);
    _loadReminders();
  }

  Future<void> deleteReminder(int id) async {
    await localDatasource.deleteReminder(id);
    await cloudDatasource.deleteReminder(id.toString());

    _loadReminders();
  }

  Future<void> editReminder(Reminder reminder) async {
    final bool update = await localDatasource.updateReminder(reminder);
    if (update) print('Recordatorio, actualizado exitosamente');
    _loadReminders();
  }
}
