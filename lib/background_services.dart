import 'package:awesome_noti_plugin/notification_services.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundServices{

  static initWorkManager(){
    Workmanager().initialize(callbackDispatcher);
  }

  static void callbackDispatcher(){
    Workmanager().executeTask((taskName, inputData){
      print('Task executing : ' + taskName);
      startTestTask();
      return Future.value(true);
    });
  }

  static void startTestTask()async {
    await NotificationService.showNotification(
      title: "Simple Notification",
      body: "Trigger Notification from Work Manager",
    );
    Workmanager().registerPeriodicTask('Task1', 'Testing Task',frequency: Duration(minutes: 15));
  }

}