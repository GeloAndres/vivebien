import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifierService {
  final notificationPluging = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //INICIALIZAR
  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIos,
    );

    notificationPluging.initialize(initSettings);
  }

  //NOTIFICATION DETAILS SETUP
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'daily notification Channel',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  //SHOW NOTIFICATION
  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    return notificationPluging.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }

  //ON NOTI TAP
}
