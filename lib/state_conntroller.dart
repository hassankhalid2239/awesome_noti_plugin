import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class StateController extends GetxController{
  Rx<DateTime> date = DateTime.now().obs;
  RxBool runningTask= false.obs;
  RxInt seconds = 0.obs;

  RxInt min= 0.obs;
  RxInt sec= 0.obs;

  void formattedTime (){
    min.value = (seconds.value ~/ 60);
    sec.value = (seconds.value % 60);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    upTime();
  }
  upTime(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      date.value= DateTime.now();
    },);
  }
}