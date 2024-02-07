
part of 'modes_bloc.dart';
class ModeEvent {

  ModeEvent();
}

class SelectWorkout extends ModeEvent {
  WorkoutStatus status;
  SelectWorkout({required this.status});
}