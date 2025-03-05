import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vivebien/domain/datasources/local_storage_datasource.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/service/local_notifier/notifier_service.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;
  late Isar dbNot;

  IsarDatasource() {
    db = openDB();
    openDbNot();
  }

  Future<void> openDbNot() async {
    dbNot = await openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([ReminderSchema],
          directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> createNewReminder(Reminder reminder) async {
    final isar = await db;
    final NotifierService notifierService = NotifierService();

    try {
      //creacion Reminder en LocalDatasource
      await isar.writeTxn(() async {
        await isar.reminders.put(reminder);
      });

      if (reminder.reminderTime.isAfter(DateTime.now())) {
        notifierService.generateReminderNotification(reminder);
      }

      return true;
    } catch (e) {
      print('Error al crear el reminder: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteReminder(int id) async {
    final isar = await db;

    try {
      await isar.writeTxn(() async {
        await isar.reminders.delete(id);
      });
      print(
          '_____IsarDatasource_____ Se elemino correctamente el recordatorio $id');
      //Sincroniza con CloudDatasource

      return true;
    } catch (e) {
      print('Error al eliminar el reminder: $e');
      return false;
    }
  }

  @override
  Future<List<Reminder>> getReminder() async {
    final isar = await db;
    final List<Reminder> remindersList = await isar.reminders.where().findAll();
    if (remindersList.isEmpty || remindersList == null) {
      print(
          '_____IsarDatasource_____ Tenemos problemas en getReminder, llega $remindersList');
      return [];
    }
    return remindersList;
  }

  @override
  Future<bool> updateReminder(Reminder reminder) {
    return createNewReminder(reminder);
  }

  Future<Reminder?> getReminderById(int id) async {
    final isar = await db;
    try {
      final reminder = await isar.reminders.get(id);
      return reminder;
    } catch (e) {
      print('Error al obtener el Reminder por ID: $e');
      return null;
    }
  }

  Stream<void> watchReminders() {
    return db.asStream().asyncExpand((isar) => isar.reminders.watchLazy());
  }
}
