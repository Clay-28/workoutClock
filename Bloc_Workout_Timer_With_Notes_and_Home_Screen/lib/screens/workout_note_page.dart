import 'package:bloc_workout_timer_test_1/bloc/note_bloc/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/workout_Notes/user_workout_notes.dart';




class WorkoutNotePage extends StatelessWidget {
  const WorkoutNotePage({super.key});



  @override
  Widget build(BuildContext context) {
    //late String data = box.get;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {Navigator.pushNamed(context, '/UserWorkoutNotesPage');},
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Test'),
        ),
        body: Center(
          child: Text( 'test'
          ),
          /// Add Note Bloc Provider
          //UserWorkoutNotes(),
        )
    );
  }
}

/*
MultiBlocProvider(
      providers: [
        BlocProvider<TimerBloc>(
        create: (BuildContext context) => TimerBloc(ticker: const Ticker()),
      ),
        BlocProvider<ScrollWheelBloc>(
          create: (BuildContext context) => ScrollWheelBloc(),
        ),
        BlocProvider<NoteBloc>(
          create: (BuildContext context) => NoteBloc(),
        )
        ],

        Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {Navigator.pushNamed(context, '/UserWorkoutNotesPage');},
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Test'),
        ),
        body: Center(
          child: Text(
            '${context.select((NoteBloc bloc)=> bloc.state.text)}'
          ),
        /// Add Note Bloc Provider
        //UserWorkoutNotes(),
        )
      ),
 */