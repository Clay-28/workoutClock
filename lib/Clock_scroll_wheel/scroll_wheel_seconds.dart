import 'package:flutter/material.dart';

class ScrollWheelSeconds extends StatelessWidget {
  const ScrollWheelSeconds({super.key, required this.seconds});
  final int seconds;
  @override
  Widget build(BuildContext context) {
    return Text(seconds.toString(),
      style: const TextStyle(
        fontSize: 25,
        color: Colors.white
      ),
    );
  }
}
