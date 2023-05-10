import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  Duration duration = const Duration();

  RxInt second = 0.obs;
  RxInt minute = 0.obs;
  RxInt hour = 0.obs;

  RxInt counterLoop = 0.obs;

  RxBool isTimerRunning = false.obs;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    FirebaseMessaging.instance.getToken().then((value) => print(value));
  }


  startTimer() {
    debugPrint('Timer Start');

    if (!isTimerRunning.value) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        incrementTime();
        counterLooping();
        update();
      });
    }
  }

  void counterLooping() {
    if (second.value % 5 == 0) {
      counterLoop += 1;

    }
  }

  void resetTime() {
    duration = const Duration();
    counterLoop.value = 0;
    second.value = 0;
    minute.value = 0;
    hour.value = 0;
    update();
  }

  void stopTimer() {
    timer?.cancel();
    isTimerRunning.value = false;
    update();
  }

  void incrementTime() {
    int intervalSecond = 1;
    isTimerRunning.value = true;

    second.value = duration.inSeconds + intervalSecond;
    duration = Duration(seconds: second.value);

    if (second.value >= 59) {
      duration = const Duration(seconds: 0);
      minute.value += 1;
      if (minute.value >= 59) {
        duration = const Duration(seconds: 0, minutes: 0);
        hour.value += 1;
        // no days
      }
    }

    update();
  }
}
