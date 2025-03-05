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
  late final Frecuencia frecuencia;
  @enumerated
  late final Estado estado;

  Reminder({
    required this.title,
    required this.description,
    required this.reminderTime,
    required this.frecuencia,
    required this.estado,
    this.id = Isar.autoIncrement,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reminderTime': reminderTime.toIso8601String(),
      'frecuencia': frecuencia.toString(),
      'estado': estado.toString(),
    };
  }
}
