import 'package:vivebien/domain/entities/reminder.dart';

class ReminderImpl extends Reminder {
  ReminderImpl({
    required super.title,
    required super.description,
    required super.reminderTime,
    required super.frecuencia,
    required super.estado,
  }) {
    if (title.isEmpty) {
      throw ArgumentError('El título no puede estar vacío.');
    }
    if (reminderTime.isBefore(DateTime.now())) {
      throw ArgumentError(
        'La fecha/hora del recordatorio no puede ser en el pasado.',
      );
    }
  }
}
