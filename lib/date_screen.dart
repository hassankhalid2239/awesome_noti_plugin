import 'dart:async';

import 'package:awesome_noti_plugin/custom_button.dart';
import 'package:flutter/material.dart';

import 'notification_services.dart';

class DateScreen extends StatefulWidget {
  DateScreen({super.key});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {

  DateTime? date;
  int hour=0;
  int minute=0;


  updateTime(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        date= DateTime.now();
      });
    },);
  }

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
    String convertedTime = '${hourIn24HourFormat.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    // print(convertedTime); // Output: "13:00" for example input "1:0 pm"
    return convertedTime;
  }

  spreadHourMinute(String horMin){
    List<String> parts = horMin.split(':');
    hour = int.parse(parts[0]);
    minute = int.parse(parts[1]);
  }

  setTime(String tim){
    String d= tim;
    String hour24 = convertTo24HourFormat(d);
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,
        title: Text('Date Screen'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          Container(
            child: Column(
              children: [
                CustomButton(
                  title: "Scheduled Notification after 5s",
                  onTap: () async {
                    setTime('9:56 am');
                    await NotificationService.showScheduleAlert(
                      title: "Scheduled Notification",
                      body: "Notification was fired after 5 seconds",
                      scheduled: true,
                      date: DateTime.now(),
                      hour: hour,
                      min: minute
                    );
                  },
                ),
                Center(
                  child: Text(date.toString()),
                ),
                Text('Year: ${date?.year}'),
                Text('Month: ${date?.month}'),
                Text('Day: ${date?.day}'),
                Text('Hour: ${date?.hour}'),
                Text('Minute: ${date?.minute}'),
                Text('Second: ${date?.second}'),
                Text('Weekday: ${date?.weekday}'),
                Center(
                  child: Text('${date?.day}/${date?.month}/${date?.year}  ${date?.hour}:${date?.minute}:${date?.second}',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),

              ],
            ),
          ),
          SizedBox(height: 15,),
          // CustomButton(title: , onTap: onTap);
        ],
      ),
    );
  }
}
