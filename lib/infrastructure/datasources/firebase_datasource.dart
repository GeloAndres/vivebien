import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vivebien/domain/datasources/cloud_storage_datasource.dart';
import 'package:vivebien/domain/entities/reminder.dart';

const String REMINDERS_COLLECTION_REF = 'reminders';

class FirebaseDatasource extends CloudStorageDatasource {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection(REMINDERS_COLLECTION_REF);

  @override
  Future<void> synchronizeData() async {}

  @override
  Future<bool> createReminder(Reminder reminder) async {
    try {
      await collectionRef.doc(reminder.id.toString()).set(reminder.toJson());
      print('se logro guardar info en firestore');
      return true;
    } catch (e) {
      print('Error al crear el reminder en Firestore: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteReminder(String id) async {
    try {
      await collectionRef.doc(id).delete();
      return true;
    } catch (e) {
      print('Error al eliminar el reminder de Firestore: $e');
      return false;
    }
  }
}
