
part of 'modes_bloc.dart';
enum WorkoutStatus {initial, ARAMP, EMOM, TABATA}

class WorkoutModeState{

  WorkoutStatus? status;
  WorkoutModeState({this.status = WorkoutStatus.initial});

  WorkoutModeState copyWith( WorkoutStatus ? status){
    return WorkoutModeState(
      status: status ?? this.status
    );
  }

}