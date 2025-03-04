import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/infrastructure/datasources/firebase_datasource.dart';
import 'package:vivebien/infrastructure/repositories/cloud_storage_repository_impl.dart';

final cloudStorageDatasourceProvider = Provider((ref) {
  return CloudStorageRepositoryImpl(cloudDb: FirebaseDatasource());
});
