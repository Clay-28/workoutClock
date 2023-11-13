import 'dart:io';

import 'package:bloc_workout_timer_test_1/screens/workout_clock_page.dart';
import 'package:bloc_workout_timer_test_1/screens/user_workout_notes_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'screens/home_page.dart';
import 'screens/workout_note_page.dart';

Future<void> main() async {
  /*
  var path = Directory.current.path;
  Hive.init(path);
  var box = await Hive.openBox('testBox');

   */

  runApp(WorkoutTimer());
}

class WorkoutTimer extends StatelessWidget {
  const WorkoutTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        '/WorkoutClockPage': (context) => WorkoutClockPage(),
        '/UserWorkoutNotePage' : (context) => UserWorkoutNotesPage(),
        '/WorkoutNotePage' : (context) => WorkoutNotePage(),

      },
    );
  }
}
