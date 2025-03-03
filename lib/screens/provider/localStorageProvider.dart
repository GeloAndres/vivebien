import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/infrastructure/datasources/isar_datasource.dart';
import 'package:vivebien/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageDatasourceProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: IsarDatasource());
});
