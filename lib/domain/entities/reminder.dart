import 'package:isar/isar.dart';
import 'package:vivebien/enum/entity_reminder/entity_reminder_enum.dart';

part 'reminder.g.dart';

@collection
class Reminder {
  Id idIsar = Isar.autoIncrement;
  final String id;
  final String title;
  final String description;
  final DateTime reminderTime;

  @enumerated
  late final Frecuencia frecuencia;
  @enumerated
  late final Estado estado;

  Reminder({
    required this.title,
    required this.description,
    required this.reminderTime,
    required this.frecuencia,
    required this.estado,
    required this.id,
    this.idIsar = Isar.autoIncrement,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idIsar': idIsar,
      'title': title,
      'description': description,
      'reminderTime': reminderTime.toIso8601String(),
      'frecuencia': frecuencia.toString(),
      'estado': estado.toString(),
    };
  }
}
