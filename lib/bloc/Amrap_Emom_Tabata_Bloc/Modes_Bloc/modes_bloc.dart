
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

part 'modes_event.dart';
part 'modes_state.dart';

class WorkoutModesBloc extends Bloc <ModeEvent, WorkoutModeState>{

  // WorkoutModeState status = WorkoutModeState(status: WorkoutStatus.initial);
  // //get test => _state.status;

  static WorkoutStatus status = WorkoutStatus.initial;





  WorkoutModesBloc(): super(
    WorkoutModeState(status: WorkoutStatus.initial)
  ){
    /// Helper Functions
    on<SelectWorkout>(_selectWorkout);
  }

  void _selectWorkout(SelectWorkout event, Emitter<WorkoutModeState> emit){
    // if(event.status == WorkoutStatus.ARAMP ) {
    //   _state = WorkoutModeState(status: event.status);
    // }
    print('event.state: ${event.status}');
    emit(state.copyWith(event.status));
    print('Workout Mode Bloc Select Workout ${state.status}');
    // if(event.status == WorkoutStatus.ARAMP) {
    //   status = event.status;
    // }
    status = event.status;

    print('\n\n Yee Haww');
  }

}
