import 'package:isar/isar.dart';
import 'package:vivebien/enum/entity_reminder/entity_reminder_enum.dart';

part 'reminder.g.dart';

@collection
class Reminder {
  Id id = Isar.autoIncrement;
  final String title;
  final String description;
  final DateTime reminderTime;

  @enumerated
  final Frecuencia frecuencia;
  @enumerated
  final Estado estado;

  Reminder({
    required this.title,
    required this.description,
    required this.reminderTime,
    required this.frecuencia,
    required this.estado,
    this.id = Isar.autoIncrement,
  });
}
