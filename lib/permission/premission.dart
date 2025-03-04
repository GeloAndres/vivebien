import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermissions() async {
  final PermissionStatus status = await Permission.notification.request();

  if (status.isGranted) {
    print('Permisos de notificación concedidos');
  } else if (status.isDenied) {
    print('Permisos de notificación denegados');
  } else if (status.isPermanentlyDenied) {
    print('Permisos de notificación denegados permanentemente');
    openAppSettings();
  }
}
