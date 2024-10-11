import 'package:awesome_noti_plugin/alert.dart';
import 'package:awesome_noti_plugin/custom_button.dart';
import 'package:awesome_noti_plugin/date_screen.dart';
import 'package:awesome_noti_plugin/state_conntroller.dart';
import 'package:awesome_noti_plugin/stop_watch%20screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

import 'notification_services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _stateController = Get.put(StateController());

  String convertTo24HourFormat(String time) {
    // Time ko split karen aur hours, minutes aur AM/PM ko extract karen
    List<String> parts = time.split(' ');
    List<String> timeParts = parts[0].split(':');

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    String period = parts[1].toLowerCase(); // AM ya PM check karen

    // Agar PM hai aur hour 12 se chhota hai to 12 hours add karen
    if (period == 'pm' && hour != 12) {
      hour += 12;
    }
    // Agar AM hai aur hour 12 hai to usay 0 mein convert karen
    if (period == 'am' && hour == 12) {
      hour = 0;
    }

    // 24-hour format return karen as a string
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.now();
    print(dt.weekday);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Awesome Notifications',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DateScreen()));
              },
              icon: Icon(Icons.date_range_sharp)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAlert()));
              },
              icon: Icon(Icons.add_alert)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StopwatchScreen()));
              },
              icon: Icon(Icons.timer)),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomButton(
                  title: "Simple Notification",
                  onTap: () async {
                    await NotificationService.showNotification(
                      title: "Title of the notification",
                      body: "Body of the notification",
                    );
                  },
                ),
                CustomButton(
                  title: "Notification With Summary",
                  onTap: () async {
                    await NotificationService.showNotification(
                      title: "Title of the notification",
                      body: "Body of the notification",
                      summary: "Small Summary",
                      notificationLayout: NotificationLayout.Inbox,
                    );
                  },
                ),
                CustomButton(
                  title: "Progress Bar Notification",
                  onTap: () async {
                    await NotificationService.showNotification(
                      title: "Title of the notification",
                      body: "Body of the notification",
                      summary: "Small Summary",
                      notificationLayout: NotificationLayout.ProgressBar,
                    );
                  },
                ),
                CustomButton(
                  title: "Message Notification",
                  onTap: () async {
                    await NotificationService.showNotification(
                      title: "Title of the notification",
                      body: "Body of the notification",
                      summary: "Small Summary",
                      notificationLayout: NotificationLayout.Messaging,
                    );
                  },
                ),
                CustomButton(
                  title: "Big Image Notification",
                  onTap: () async {
                    await NotificationService.showNotification(
                      title: "Title of the notification",
                      body: "Body of the notification",
                      summary: "Small Summary",
                      notificationLayout: NotificationLayout.BigPicture,
                      bigPicture:
                          "https://files.tecnoblog.net/wp-content/uploads/2019/09/emoji.jpg",
                    );
                  },
                ),
                CustomButton(
                  title: "Action Buttons Notification",
                  onTap: () async {
                    await NotificationService.showNotification(
                        title: "Title of the notification",
                        body: "Body of the notification",
                        payload: {
                          "navigate": "true",
                        },
                        actionButtons: [
                          NotificationActionButton(
                            key: 'check',
                            label: 'Check it out',
                            actionType: ActionType.SilentAction,
                            color: Colors.green,
                          )
                        ]);
                  },
                ),
                // CustomButton(
                //   title: "Scheduled Notification",
                //   onTap: () async {
                //     await NotificationService.showNotification(
                //       title: "Scheduled Notification",
                //       body: "Notification was fired after 5 seconds",
                //       scheduled: true,
                //       interval: 5,
                //     );
                //   },
                // ),
                CustomButton(
                  title: "Scheduled Notification after 5s",
                  onTap: () async {
                    DateTime dt = DateTime(DateTime.now().year);
                    await NotificationService.showScheduleNotification(
                      title: "Scheduled Notification",
                      body: "Notification was fired after 5 seconds",
                      scheduled: true,
                      date: DateTime.now().add(const Duration(seconds: 5)),
                    );
                  },
                ),
                SizedBox(height: 15,),
                CustomButton(title: 'Start Periodic WorkManager', onTap: (){
                  Workmanager().registerPeriodicTask('Task1', 'Backup',frequency: Duration(minutes: 15));
                  _stateController.runningTask.value=true;
                }),
                SizedBox(height: 15,),

                CustomButton(title: 'Cancel Periodic WorkManager', onTap: (){
                  Workmanager().cancelByUniqueName('Task1');
                  _stateController.runningTask.value=false;
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
