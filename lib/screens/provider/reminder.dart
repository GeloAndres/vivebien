import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/domain/repositories/cloud_storage_repository.dart';
import 'package:vivebien/domain/repositories/local_storage_repository.dart';
import 'package:vivebien/enum/entity_reminder/entity_reminder_enum.dart';
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

  Future<void> createReminder(Reminder newReminder) async {
    final bool create = await localDatasource.createNewReminder(newReminder);
    if (create) {
      _loadReminders();
      //sincronizar
      await cloudDatasource.createReminder(newReminder);
    }
  }

  Future<void> deleteReminder(int id) async {
    final bool delete = await localDatasource.deleteReminder(id);
    if (delete) {
      _loadReminders();
      //sincronizar
      await cloudDatasource.deleteReminder(id.toString());
    }
  }

  Future<void> editReminder(Reminder reminder) async {
    final bool update = await localDatasource.updateReminder(reminder);
    if (update) {
      print('Recordatorio, actualizado exitosamente');
      //sincronizar
      await cloudDatasource.updateReminder(reminder);
      _loadReminders();
    }
  }

  Future<bool> completStateReminder(int id) async {
    try {
      final index = state.indexWhere((r) => r.id == id);
      if (index == -1) {
        print('Reminder con ID $id no encontrado');
        return false;
      }

      final updatedReminder = state[index];
      updatedReminder.estado = Estado.Completado;

      state = [...state]..[index] = updatedReminder;

      await localDatasource.updateReminder(updatedReminder);
      await cloudDatasource.updateReminder(updatedReminder);

      print('Cambio el estado a completado: ${updatedReminder.title}');
      return true;
    } catch (e) {
      print('Error al cambiar el estado del Reminder: $e');
      return false;
    }
  }

  Future<bool> postponeReminder(int id) async {
    try {
      final Reminder reminderUpState = await reminderById(id);

      if (reminderUpState == null) {
        print('Reminder con ID $id no encontrado');
        return false;
      }
      //Determinar completada el recordatorio

      // reminderUpState. = Estado.Completado;
      await editReminder(reminderUpState);
      print('Cambio el estado a completado: ${reminderUpState.title}');
      return true; // Indica que la operación fue exitosa
    } catch (e) {
      print('Error al cambiar el estado del Reminder: $e');
      return false; // Indica que la operación falló
    } finally {
      _loadReminders(); // Siempre recarga los Reminders
    }
  }

  Future<Reminder> reminderById(int id) async {
    final Reminder? reminderUpState = await localDatasource.getReminderById(id);

    return reminderUpState!;
  }
}
