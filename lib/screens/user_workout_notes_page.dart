import 'package:WorkoutClock/services/workout_note_services.dart';
import 'package:WorkoutClock/workout_notes/User_Notes_Widget_Card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../bloc/user_note_bloc/user_notes_bloc.dart';
import '../models/user_workout_data.dart';
import '../services/colors.dart';
import '../workout_notes/edit_user_notes.dart';


bool small = true;

class UserWorkoutNotesPage extends StatefulWidget {
  const UserWorkoutNotesPage({super.key});

  @override
  State<UserWorkoutNotesPage> createState() => _UserWorkoutNotesPageState();
}

class _UserWorkoutNotesPageState extends State<UserWorkoutNotesPage> {
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
        providers: [
    BlocProvider<UserNotesBloc>(
    create: (BuildContext context) => UserNotesBloc()..add(LoadingUserData())),
    ],
    child:
    Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('All Workout Notes',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          leading: IconButton(
            onPressed: () {Navigator.pushNamed(context, '/HomePage');},
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.blueAccent, Colors.black],
                    stops: [-0.5,0.5,1.5]
                )
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0 ),
          child: BlocBuilder<UserNotesBloc,UserNoteState>(
            builder: (context, state) {
              if(state.status == UserNoteStatus.loading){
                const Center(child: CircularProgressIndicator());
              }
              if (state.status == UserNoteStatus.loaded) {
                return ValueListenableBuilder(

                  /// As the valueListenable changes , this builder will update
                  /// For this project: Every time our userDataBox or Workout notes changes
                  /// A listView will update with its changes

                    valueListenable: Hive.box<UserWorkoutNotes>('userDataBox').listenable(),
                    builder: (context, Box<UserWorkoutNotes> userWorkoutNotes, _ ) {

                      List<UserWorkoutNotes> allWorkoutNotes = userWorkoutNotes.values.toList();

                      return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(height: 20,),
                          itemCount: userWorkoutNotes.length,
                          itemBuilder: (context, index) {

                            UserWorkoutNotes workoutNote = allWorkoutNotes[(userWorkoutNotes.length - 1) - index];
                            return UserNotesCard(index: index, workoutNote: workoutNote);
                          }
                      );
                    });
              }
              return Center(child: Text('error'),);
            }
          ),
        )
    )
    );
  }
}
