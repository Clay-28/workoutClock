import 'package:flutter/material.dart';

class ScrollWheelMinutes extends StatelessWidget {
  const ScrollWheelMinutes({super.key, required this.minutes});
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${minutes.toString()} min',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 23,
        color: Colors.white,
      ),
    );
  }
}
