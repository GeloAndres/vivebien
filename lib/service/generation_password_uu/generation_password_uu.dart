import 'package:uuid/uuid.dart';

String generarIdUnico() {
  const uuid = Uuid();
  return uuid.v4();
}
