import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/enum/entity_reminder/entity_reminder_enum.dart';

final List<Reminder> recordatorioListaTesting = [
  Reminder(
    title: 'Estirar espalda',
    description: 'Acuerdate de sentarte con la espada derecha',
    reminderTime: DateTime(2025, 10, 15, 3, 30),
    frecuencia: Frecuencia.Diario,
    estado: Estado.Completado,
  ),
];
