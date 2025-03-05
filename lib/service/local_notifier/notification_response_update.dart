import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void onNotificationTap(NotificationResponse notificationResponse) {
  //Id de mi reminder
  final reminderId = int.tryParse(notificationResponse.payload ?? '');

  //El id del buttom del notification
  switch (notificationResponse.actionId) {
    case 'completada':
      if (reminderId != null) {
        print('recordatorio completado Id: $reminderId');
      } else {
        print('recordatorio completado pero no llega el Id');
      }

      //cambiar el estado
      break;
    case 'aplazar':
      if (reminderId != null) {
        print('Aplazamos el recordatorio Id: $reminderId');
      } else {
        print('No tenemos la id del recordatorio para aplazarlo');
      }
      break;
    default:
      print('presionaste la notificación');
      break;
  }
}
