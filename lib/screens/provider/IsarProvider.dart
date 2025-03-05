import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/infrastructure/datasources/isar_datasource.dart';

final localIsarProvider = Provider((ref) {
  return IsarDatasource();
});
