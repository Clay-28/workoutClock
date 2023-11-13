import 'package:hive/hive.dart';
part 'user_workout_data.g.dart';

@HiveType(typeId: 1)
class UserWorkoutNotes {
  UserWorkoutNotes({
    required this.workoutNotes,
    required this.day,
    required this.year,
    required this.weekDay,
    required this.month,
    required this.workoutTime,
  });

  @HiveField(0)
  String workoutNotes;

  @HiveField(1)
  String year;

  @HiveField(2)
  String month;

  @HiveField(3)
  int day;

  @HiveField(4)
  int weekDay;

  @HiveField(5)
  int workoutTime;
}