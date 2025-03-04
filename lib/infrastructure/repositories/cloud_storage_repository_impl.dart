import 'package:vivebien/domain/datasources/cloud_storage_datasource.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/domain/repositories/cloud_storage_repository.dart';

class CloudStorageRepositoryImpl extends CloudStorageRepository {
  final CloudStorageDatasource cloudDb;

  CloudStorageRepositoryImpl({required this.cloudDb});

  @override
  Future<void> synchronizeData() {
    // TODO: implement synchronizeData
    throw UnimplementedError();
  }

  @override
  Future<bool> createReminder(Reminder reminder) {
    return cloudDb.createReminder(reminder);
  }

  @override
  Future<bool> deleteReminder(String id) {
    return cloudDb.deleteReminder(id);
  }
}
