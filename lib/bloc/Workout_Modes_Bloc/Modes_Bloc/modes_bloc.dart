
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

part 'modes_event.dart';
part 'modes_state.dart';

class WorkoutModesBloc extends Bloc <ModeEvent, WorkoutModeState>{

  WorkoutModesBloc(): super(
    WorkoutModeState(status: WorkoutStatus.initial)
  ){
    /// Helper Functions
    on<SelectWorkout>(_selectWorkout);
  }

  void _selectWorkout(SelectWorkout event, Emitter<WorkoutModeState> emit){
    emit(state.copyWith(event.status));
  }

}
