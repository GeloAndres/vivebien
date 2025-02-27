enum Frecuencia { Unico, Diario, Semanal, Personalizado }

enum Estado { Pendiente, Completado, Omitido }

abstract class Reminder {
  final String title;
  final String description;
  final DateTime reminderTime;
  final Frecuencia frecuencia;
  final Estado estado;

  Reminder({
    required this.title,
    required this.description,
    required this.reminderTime,
    required this.frecuencia,
    required this.estado,
  });
}
