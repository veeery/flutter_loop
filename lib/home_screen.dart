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
      body: GetBuilder<TimerController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TimerCard(nameTimer: 'Hour', indicatorTimer: '${timerController.hour}'),
                    TimerCard(nameTimer: 'Minute', indicatorTimer: '${timerController.minute}'),
                    TimerCard(nameTimer: 'Second', indicatorTimer: '${timerController.second}')
                  ],
                ),
                SizedBox(height: 25),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text('Counter Loop : ${timerController.counterLoop}'),
                    ],
                  ),
                ),
                SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    timerController.isTimerRunning.value
                        ? GestureDetector(
                            onTap: () => timerController.stopTimer(),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                              width: 100,
                              height: 25,
                              child: const Center(child: Text('Stop')),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => timerController.startTimer(),
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.greenAccent, borderRadius: BorderRadius.circular(20)),
                              width: 100,
                              height: 25,
                              child: const Center(child: Text('Start')),
                            ),
                          ),
                    GestureDetector(
                      onTap: () => timerController.resetTime(),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(20)),
                        width: 100,
                        height: 25,
                        child: const Center(child: Text('Reset')),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
