import 'package:awesome_noti_plugin/custom_button.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'notification_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,
        title: const Text('Awesome  Notifications',),
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
                CustomButton(
                  title: "Scheduled Notification",
                  onTap: () async {
                    await NotificationService.showNotification(
                      title: "Scheduled Notification",
                      body: "Notification was fired after 5 seconds",
                      scheduled: true,
                      interval: 5,
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
