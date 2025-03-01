import 'package:vivebien/domain/entities/reminder.dart';

class ReminderImpl extends Reminder {
  ReminderImpl({
    required super.id,
    required super.title,
    required super.description,
    required super.reminderTime,
    required super.frecuencia,
    required super.estado,
  });
}
