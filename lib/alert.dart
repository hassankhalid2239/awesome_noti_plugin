import 'package:awesome_noti_plugin/state_conntroller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_button.dart';
import 'notification_services.dart';

class MyAlert extends StatelessWidget {
  MyAlert({super.key});

  final _stateController = Get.put(StateController());

  final TextEditingController userTime = TextEditingController();

  int hour = 0;

  int minute = 0;

  String convertTo24HourFormat(String t) {
    // Input format: "h:mm am/pm"
    String time = t; // Yahan aap apna desired time input de sakte hain

    // Split kar ke hour, minute aur period (am/pm) extract karte hain
    List<String> parts = time.split(' ');
    List<String> timeParts = parts[0].split(':');

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    String period = parts[1].toLowerCase(); // AM ya PM

    // 12-hour se 24-hour format mein convert karna
    int hourIn24HourFormat = (period == 'pm' && hour != 12) ? hour + 12 : hour;
    if (period == 'am' && hour == 12) {
      hourIn24HourFormat = 0;
    }

    // Format output as "HH:mm"
    String convertedTime =
        '${hourIn24HourFormat.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    // print(convertedTime); // Output: "13:00" for example input "1:0 pm"
    return convertedTime;
  }

  spreadHourMinute(String horMin) {
    List<String> parts = horMin.split(':');
    hour = int.parse(parts[0]);
    minute = int.parse(parts[1]);
  }

  setTime(String tim) {
    String hour24 = convertTo24HourFormat(tim);
    spreadHourMinute(hour24);
    if (kDebugMode) {
      print('hour:$hour');
    }
    if (kDebugMode) {
      print('Minute:$minute');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  '${_stateController.date.value.hour}:${_stateController.date.value.minute}:${_stateController.date.value.second}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                );
              }),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: userTime,
                decoration: const InputDecoration(
                    hintText: 'Ex: 12:29 am',
                    label: Text('Time'),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                title: "Scheduled Notification after 5s",
                onTap: () async {
                  setTime(userTime.text.trim());
                  await NotificationService.showScheduleAlert(
                      title: "Scheduled Notification",
                      body: "Notification was fired after 5 seconds",
                      scheduled: true,
                      date: DateTime.now(),
                      hour: hour,
                      min: minute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
