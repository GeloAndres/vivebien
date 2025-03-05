import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/screens/provider/reminder.dart';

void onNotificationTap(NotificationResponse notificationResponse) async {
  final reminderId = int.tryParse(notificationResponse.payload ?? '');
  final container = ProviderContainer();
  final askReminderProviderExpress =
      container.read(askReminderProvider.notifier);

  switch (notificationResponse.actionId) {
    case 'completada':
      if (reminderId != null) {
        print('recordatorio completado Id: $reminderId');
        await askReminderProviderExpress.completStateReminder(reminderId);
      } else {
        print('recordatorio completado pero no llega el Id');
      }

      break;
    case 'aplazar':
      if (reminderId != null) {
        final container = ProviderContainer();
        final askReminderProviderExpress =
            container.read(askReminderProvider.notifier);

        await askReminderProviderExpress.postponeReminder(reminderId);

        print('recordatorio aplazado 2 minutos Id: $reminderId');
      } else {
        print('No tenemos la id del recordatorio para aplazarlo');
      }
      break;
    default:
      print('presionaste la notificación');
      break;
  }
}

@pragma('vm:entry-point')
void onNotificationTapBackground(
    NotificationResponse notificationResponse) async {
  final reminderId = int.tryParse(notificationResponse.payload ?? '');

  final container = ProviderContainer();
  final askReminderProviderExpress =
      container.read(askReminderProvider.notifier);

  switch (notificationResponse.actionId) {
    case 'completada':
      if (reminderId != null) {
        print('recordatorio completado Id: $reminderId');

        await askReminderProviderExpress.completStateReminder(reminderId);
      } else {
        print('recordatorio completado pero no llega el Id');
      }
      break;
    case 'aplazar':
      if (reminderId != null) {
        await askReminderProviderExpress.postponeReminder(reminderId);

        print('recordatorio aplazado 2 minutos Id: $reminderId');
      } else {
        print('No tenemos la id del recordatorio para aplazarlo');
      }
      break;
    default:
      print('presionaste la notificación');
      break;
  }
}
