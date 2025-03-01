import 'package:vivebien/enum/entity_reminder/entity_reminder_enum.dart';

class Reminder {
  final int id;
  final String title;
  final String description;
  final DateTime reminderTime;
  final Frecuencia frecuencia;
  final Estado estado;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.reminderTime,
    required this.frecuencia,
    required this.estado,
  });
}
