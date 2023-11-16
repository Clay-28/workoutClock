import 'package:WorkoutClock/services/workout_note_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user_workout_data.dart';
import '../../models/workout_data.dart';

part 'user_note_events.dart';
part 'user_note_state.dart';

class UserNotesBloc extends Bloc<UserNotesEvent,UserNoteState>{

  WorkoutNotesServices userData = WorkoutNotesServices();

  UserNotesBloc() : super(UserNoteState(status: UserNoteStatus.loading))
  {
    on<EditWorkoutNote>(_onEditWorkoutNote);
    on<DeleteWorkoutNote>(_onDeleteWorkoutNote);
    on<LoadingUserData>(_onLoadingUserData);
  }


  void _onEditWorkoutNote(EditWorkoutNote event, Emitter<UserNoteState> emit) {


    userData.updateWorkoutNote(event.index, event.userWorkoutNotes);

    emit(state.copyWith(userWorkoutData: userData.fetchWorkoutNotes()));
  }


  void _onDeleteWorkoutNote(DeleteWorkoutNote event, Emitter<UserNoteState> emit) {

    userData.deleteUserNote(event.index);
    emit(state.copyWith(userWorkoutData: userData.fetchWorkoutNotes()));
  }

  void _onLoadingUserData(LoadingUserData event, Emitter<UserNoteState> emit) async{
    await userData.init();
    emit(UserNoteState(userWorkoutData: userData.fetchWorkoutNotes(), status:UserNoteStatus.loaded));
  }

}