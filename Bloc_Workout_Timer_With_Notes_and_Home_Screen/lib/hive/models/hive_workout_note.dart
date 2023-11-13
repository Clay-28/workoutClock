import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_generator/hive_generator.dart';
part 'hive_workout_note.g.dart';

@HiveType(typeId: 1)
class HiveWorkoutNotes {
  HiveWorkoutNotes({
    required this.title,
    required this.text,
    });

  @HiveField(0)
  String title;

  @HiveField(1)
  String text;

  /*
  @HiveField(2)
  String year;

  @HiveField(3)
  String month;

  @HiveField(4)
  String day;

   */

  @override
  String toString() {
    return '$title: $text';
  }
}

