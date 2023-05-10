import 'package:flutter/material.dart';

class TimerCard extends StatelessWidget {
  final String indicatorTimer;
  final String nameTimer;

  const TimerCard({
    super.key,
    required this.indicatorTimer,
    required this.nameTimer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          nameTimer,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(color: Colors.grey[350], borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            indicatorTimer,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
