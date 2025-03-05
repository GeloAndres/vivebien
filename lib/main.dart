import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivebien/login/login_screen.dart';
import 'package:vivebien/permission/premission.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vivebien/screens/provider/reminder.dart';
import 'package:vivebien/service/local_notifier/notifier_service.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await requestNotificationPermissions();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: Consumer(builder: (context, ref, _) {
        NotifierService().initialize(ref);
        return MainApp();
      }),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    AppLifecycleListener(
      onResume: () {
        print("ViveBien volvió a primer plano");
        ref.read(askReminderProvider.notifier).loadReminders();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
