import 'package:bloc_workout_timer_test_1/bloc/note_bloc/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWorkoutNotes extends StatelessWidget {
  UserWorkoutNotes({super.key});

  @override
  Widget build(BuildContext context) {
    //double totalTime = context.select((TimerBloc bloc) => bloc.totalBreakTime.toDouble());
    String notes = context.select((NoteBloc bloc) => bloc.state.text);
    //String test = context.select(NoteBloc bloc) => bloc.state.
    /// Create a Block Builder
    /// Vertical List View Builder
    /// Notes Description
    /// Date Created, Title & duration, first sentence
    /// onPressed -> full description & editable
    return Center(
      child: Text(
        notes
      ),
    );
  }
}
