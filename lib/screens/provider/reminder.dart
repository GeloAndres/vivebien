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
    loadReminders();
    _watchReminders();
  }

  Future<void> loadReminders() async {
    final reminders = await localDatasource.getReminder();
    reminders.sort((a, b) {
      if (a.estado == Estado.Completado && b.estado != Estado.Completado) {
        return 1;
      } else if (a.estado != Estado.Completado &&
          b.estado == Estado.Completado) {
        return -1;
      }
      return a.reminderTime.compareTo(b.reminderTime);
    });

    Future.delayed(Duration(milliseconds: 900));
    state = reminders;
  }

  void _watchReminders() {
    localDatasource.watchReminders().listen((_) {
      loadReminders();
    });
  }

  Future<void> createReminder(Reminder newReminder) async {
    final bool create = await localDatasource.createNewReminder(newReminder);
    if (create) {
      //sincronizar
      await cloudDatasource.createReminder(newReminder);
      print('Recordatorio que esta sincroniza');
      print('Recordatorio     : ${newReminder.title}');
      print('Id personalizado : ${newReminder.id}');
      print('Id isar          : ${newReminder.idIsar}');
    }
  }

  Future<void> deleteReminder(int id) async {
    final bool delete = await localDatasource.deleteReminder(id);
    if (delete) {
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
    }
  }

  Future<bool> completStateReminder(int id) async {
    try {
      Reminder reminder = await reminderById(id);
      //opcion del cheking
      if (reminder.estado == Estado.Completado) {
        Reminder CompletReminder = Reminder(
            id: reminder.id,
            title: reminder.title,
            description: reminder.description,
            reminderTime: reminder.reminderTime,
            frecuencia: reminder.frecuencia,
            estado: Estado.Pendiente);

        editReminder(CompletReminder);
        return true;
      }
      Reminder CompletReminder = Reminder(
          id: reminder.id,
          title: reminder.title,
          description: reminder.description,
          reminderTime: reminder.reminderTime,
          frecuencia: reminder.frecuencia,
          estado: Estado.Completado);

      editReminder(CompletReminder);
      print('Cambio el estado a completado: ${reminder.title}');
      return true;
    } catch (e) {
      print('Error al cambiar el estado del Reminder: $e');
      return false;
    }
  }

  Future<bool> postponeReminder(int id) async {
    try {
      final Reminder reminder = await reminderById(id);

      if (reminder == null) {
        print('Reminder con ID $id no encontrado');
        return false;
      }
      Reminder newReminder = Reminder(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description,
        reminderTime: reminder.reminderTime.add(Duration(minutes: 3)),
        frecuencia: reminder.frecuencia,
        estado: Estado.Omitido,
      );

      await editReminder(newReminder);
      print(
          'Se a aplazado el recordatorio: ${reminder.title}, de ${reminder.reminderTime} a ${newReminder.reminderTime}}');
      return true;
    } catch (e) {
      print('Error al cambiar el estado del Reminder: $e');
      return false;
    } finally {
      loadReminders();
    }
  }

  Future<Reminder> reminderById(int id) async {
    final Reminder? reminderUpState = await localDatasource.getReminderById(id);

    return reminderUpState!;
  }
}
