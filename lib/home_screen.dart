import 'package:flutter/material.dart';
import 'package:flutter_loop/timer_card.dart';
import 'package:flutter_loop/timer_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Loop'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimerWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildTimerWidget() {
    return Column(
      children: [
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TimerCard(nameTimer: 'Hour',indicatorTimer: '${timerController.hour}'),
              TimerCard(nameTimer: 'Minute',indicatorTimer: '${timerController.minute}'),
              TimerCard(nameTimer: 'Second',indicatorTimer: '${timerController.second}')
            ],
          );
        }),
        // GetBuilder<TimerController>(
        //   builder: (_) {
        //     return Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         TimerCard(nameTimer: 'Hour',indicatorTimer: '${timerController.hour}'),
        //         TimerCard(nameTimer: 'Minute',indicatorTimer: '${timerController.minute}'),
        //         TimerCard(nameTimer: 'Second',indicatorTimer: '${timerController.second}')
        //       ],
        //     );
        //   },
        // ),
        SizedBox(height: 100),
        GestureDetector(
          onTap: () => timerController.startTimer(),
          child: Container(
            color: Colors.red,
            width: 100,
            height: 100,
          ),
        ),
        GestureDetector(
          onTap: () => timerController.resetTime(),
          child: Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
        ),
        GestureDetector(
          onTap: () => timerController.stopTimer(),
          child: Container(
            color: Colors.amber,
            width: 100,
            height: 100,
          ),
        )

      ],
    );
  }
}
