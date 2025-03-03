import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/domain/repositories/local_storage_repository.dart';
import 'package:vivebien/screens/provider/localStorageProvider.dart';

//Estado de la lista Remindes.isar
final askReminderProvider =
    StateNotifierProvider<ReminderProvider, List<Reminder>>((ref) {
  final datasource = ref.read(localStorageDatasourceProvider);
  ;
  return ReminderProvider(isar: datasource);
});

class ReminderProvider extends StateNotifier<List<Reminder>> {
  final LocalStorageRepository isar;
  ReminderProvider({required this.isar}) : super([]) {
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final reminders = await isar.getReminder();
    state = reminders;
  }

  Future<void> addReminder(Reminder newReminder) async {
    await isar.createNewReminder(newReminder);
    _loadReminders();
  }

  Future<void> deleteReminder(int id) async {
    await isar.deleteReminder(id);
    _loadReminders();
  }

  Future<void> editReminder(Reminder reminder) async {
    final bool update = await isar.updateReminder(reminder);
    if (update) print('Recordatorio, actualizado exitosamente');
    _loadReminders();
  }
}
