import 'package:awesome_noti_plugin/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'notification_services.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    Get.snackbar('Debug Print', 'Task Executing: $taskName');
    NotificationService.showNotification(
      title: "Simple Notification",
      body: "Notification from Work Manager after Every 15 Minutes",
    );
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  Workmanager().initialize(callbackDispatcher);
  // BackgroundServices.initWorkManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Awesome Notifications',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
