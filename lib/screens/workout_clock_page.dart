import 'package:flutter/material.dart';

import 'Main_workout_clock_screen.dart';


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
