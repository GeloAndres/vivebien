import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/testing/db_reminde.dart';

final askReminderProvider =
    StateNotifierProvider<ReminderProvider, List<Reminder>>((ref) {
      return ReminderProvider();
    });

class ReminderProvider extends StateNotifier<List<Reminder>> {
  ReminderProvider() : super(recordatorioListaTesting);

  void addReminder(Reminder newReminder) {
    state = [...state, newReminder];
    recordatorioListaTesting.add(newReminder);
  }
}
