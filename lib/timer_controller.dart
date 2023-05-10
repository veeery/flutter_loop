import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  Duration duration = const Duration();

  RxInt second = 0.obs;
  RxInt minute = 0.obs;
  RxInt hour = 0.obs;

  RxBool isTimerRunning = false.obs;

  Timer? timer;

  startTimer() {
    debugPrint('Timer Start');
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      incrementTime();
      update();
    });
  }

  void resetTime() {
    duration = const Duration();
    second = 0.obs;
    minute = 0.obs;
    hour = 0.obs;
    update();
  }

  void stopTimer() {
    timer?.cancel();
    triggeredTimerStatus();
    update();
  }

  void incrementTime() {
    int intervalSecond = 1;
    triggeredTimerStatus();

    second.value = duration.inSeconds + intervalSecond;
    duration = Duration(seconds: second.value);

    if (second.value >= 3) {
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


  triggeredTimerStatus() {
    isTimerRunning.value != isTimerRunning.value;
    update();
  }
}
