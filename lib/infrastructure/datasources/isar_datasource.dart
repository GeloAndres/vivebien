import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vivebien/domain/datasources/local_storage_datasource.dart';
import 'package:vivebien/domain/entities/reminder.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
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

    try {
      //creacion Reminder en LocalDatasource
      await isar.writeTxn(() async {
        await isar.reminders.put(reminder);
      });

      //Sincroniza con CloudDatasource

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
    //Sincroniza con CloudDatasource

    return createNewReminder(reminder);
  }
}
