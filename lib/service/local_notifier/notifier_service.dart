import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/domain/entities/reminder.dart';
import 'package:vivebien/service/local_notifier/notification_response_update.dart';

class NotifierService {
  static final NotifierService _instance = NotifierService._internal();
  factory NotifierService() => _instance;
  NotifierService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize(WidgetRef ref) async {
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

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse:
            onNotificationTapBackground);
  }

  //control de notificaciones con tiempo
  void generateReminderNotification(Reminder reminder) {
    final now = DateTime.now();
    final delay = reminder.reminderTime.difference(now);

    Future.delayed(delay, () {
      reminderNotification(reminder);
    });
  }

  Future<void> showInstantNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('instant_channel', 'instant Notifications',
            channelDescription: 'Channel for instant notification',
            importance: Importance.max,
            priority: Priority.high);

    const NotificationDetails platformChannelSpredifies =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpredifies, payload: 'instant');
  }

  Future<void> reminderNotification(Reminder reminder) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'instant_channel',
      'instant Notifications',
      channelDescription: 'Channel for instant notification',
      importance: Importance.max,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('completada', 'Completada',
            showsUserInterface: true),
        AndroidNotificationAction('aplazar', 'Aplazar 3 minutos',
            showsUserInterface: true),
      ],
    );

    const NotificationDetails platformChannelSpredifies =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(reminder.id, reminder.title,
        reminder.description, platformChannelSpredifies,
        payload: reminder.id.toString());
  }
}
