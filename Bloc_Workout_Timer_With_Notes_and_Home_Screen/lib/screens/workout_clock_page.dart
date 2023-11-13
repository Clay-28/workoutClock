import 'package:flutter/material.dart';

import 'workout_clock.dart';


class WorkoutClockPage extends StatelessWidget {
  const WorkoutClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: WorkoutClock(),
        ),
    );
  }
}
