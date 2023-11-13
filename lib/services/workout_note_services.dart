
import 'package:hive/hive.dart';
import '../models/months.dart';
import '../models/user_workout_data.dart';


class WorkoutNotesServices{

  late Box<UserWorkoutNotes> _workoutNotes;

  Future<void> init() async {
    _workoutNotes = await Hive.openBox<UserWorkoutNotes>('userDataBox');
  }

  List<UserWorkoutNotes> fetchWorkoutNotes(){
    return _workoutNotes.values.toList();
  }

  Future<void> addWorkoutNote(String notes, int workoutTime) async{

    await _workoutNotes.add(UserWorkoutNotes(
        workoutNotes: notes,
        year: DateTime.now().year.toString(),
        month: Month().fetchMonth(DateTime.now().month).toString(),
        day: DateTime.now().day,
        weekDay: DateTime.now().weekday,
        workoutTime: workoutTime
    ));

  }

  Future<void> updateWorkoutNote(int index, UserWorkoutNotes notes) async{
    await _workoutNotes.putAt((_workoutNotes.values.length-1)-index, notes);
  }

  List<UserWorkoutNotes> deleteUserNote(int index){
    _workoutNotes.deleteAt((_workoutNotes.values.length -1) - index);
    return _workoutNotes.values.toList();
  }

  Future<void> closeHive() async {
   await _workoutNotes.close();
  }

}

