import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotifierService {
  static final NotifierService _instance = NotifierService._internal();
  factory NotifierService() => _instance;
  NotifierService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );
  }

  void _onNotificationTap(NotificationResponse response) {
    print('notification clicked: ${response.payload}}');
  }

  Future<void> showInstantNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('instant_channel', 'instant Notifications',
            channelDescription: 'Channel for instant notification',
            importance: Importance.max,
            priority: Priority.high);

    const NotificationDetails platformChannelSpredifies =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0, 'title of notification',
        'Description of notification', platformChannelSpredifies,
        payload: 'instant');
  }

  Future<void> scheduleNotification(DateTime scheduledDateTime) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('instant_channel', 'instant Notifications',
            channelDescription: 'Channel for instant notification',
            importance: Importance.max,
            priority: Priority.high);

    const NotificationDetails platformChannelSpredifies =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'title of notification',
        'Description of notification',
        tz.TZDateTime.from(scheduledDateTime, tz.local),
        platformChannelSpredifies,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'scheduled',
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }
}
