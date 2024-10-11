import 'dart:async';

import 'package:awesome_noti_plugin/state_conntroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

import 'custom_button.dart';

class BackTaskScreen extends StatefulWidget {
  const BackTaskScreen({super.key});

  @override
  State<BackTaskScreen> createState() => _BackTaskScreenState();
}

class _BackTaskScreenState extends State<BackTaskScreen> {
  final _stateController = Get.put(StateController());
  Timer? _timer;
  void _startStopwatch() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _stateController.seconds.value++;
        _stateController.formattedTime();
        if (_stateController.seconds.value >= 900) {
          // 900 seconds = 15 minutes
          _stateController.seconds.value = 0; // Reset stopwatch
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: const Text('Stopwatch App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  '${_stateController.min.value.toString().padLeft(2, '0')}:${_stateController.sec.value.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.red),
                );
              }),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  title: 'Start Periodic WorkManager',
                  onTap: () {
                    Workmanager().registerPeriodicTask('Task1', 'Backup',
                        frequency: const Duration(minutes: 15));
                    _stateController.runningTask.value = true;
                    _startStopwatch();
                  }),
              const SizedBox(
                height: 15,
              ),
              Obx(() {
                if (_stateController.runningTask.value == true) {
                  return CustomButton(
                      title: 'Cancel Periodic WorkManager',
                      onTap: () {
                        Workmanager().cancelByUniqueName('Task1');
                        _stateController.runningTask.value = false;
                        _timer?.cancel();
                        _stateController.seconds.value = 0;
                        _stateController.sec.value = 0;
                        _stateController.min.value = 0;
                      });
                } else {
                  return const SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
