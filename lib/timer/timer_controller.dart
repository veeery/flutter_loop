import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase/notification_service.dart';
import '../network/app_dio.dart';

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
    NotificationService.firebaseForegroundService();
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

  Future sendNotification() async {
    await AppDio.executeApiWithTryCatch(() async {
      await AppDio.dio().post(
        'send',
        data: {
          "to": "/topics/support",
          // "to": "cxmNZ-1iQWSl8QnZHi47wT:APA91bFVmoNSqQo1OeYymutdHrMkj46xrc6Pbdcw_fidZD-C3eQhyuBGYInkScCfBOdYFjU1fF4mBy-kaio2rklAegnlYePXtsIPpDjb6HoPitP-PF0cfieWr1_dNSGVrnjk9gAz1NQx",
          "notification": {"title": "Test Notification", "body": "payload"},
          "type": "type-a",
          "data": {"body": "this is subtitle", "title": "this is title", "click_action": "FLUTTER_NOTIFICATION_CLICK"},
          "priority": "high"
        },
        options: AppDio.headersToken(),
      );
    });
  }

  void counterLooping() {
    if (second.value % 5 == 0) {
      counterLoop += 1;
      if (counterLoop.value % 6 == 0) {
        // send notification
        sendNotification();
      }
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
