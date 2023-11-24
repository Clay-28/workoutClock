import 'package:WorkoutClock/services/workout_note_services.dart';
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
            onPressed: () {Navigator.pushNamed(context, '/');},
            icon: const Icon(Icons.arrow_back_ios_new),
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

                  // use Provider
                    valueListenable: Hive.box<UserWorkoutNotes>('userDataBox')
                        .listenable(),
                    builder: (context, Box<UserWorkoutNotes> userWorkoutNotes,
                        _) {

                      List<UserWorkoutNotes> allWorkoutNotes = userWorkoutNotes.values.toList();
                      //Future<List<UserWorkoutNotes>> allWorkoutNotes = WorkoutNotesServices().init().then((value) => WorkoutNotesServices().fetchWorkoutNotes());

                      return ListView.separated(
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 20,),
                          itemCount: userWorkoutNotes.length,
                          itemBuilder: (context, index) {
                            UserWorkoutNotes workoutNote = allWorkoutNotes[(userWorkoutNotes
                                .length - 1) - index];
                            return Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // An action can be bigger than the others.
                                      flex: 1,
                                      onPressed: (BuildContext context) {
                                        BlocProvider.of<UserNotesBloc>(context)
                                            .add(
                                            DeleteWorkoutNote(index: index));
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ]
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15))
                                ),
                                width: double.infinity,
                                child: ListTile(
                                  leading: Column(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(
                                              Icons.circle_rounded,
                                              size: 45,
                                              color: Colors
                                                  .white //ColorsPallet().fetchColor(workoutNote.weekDay),
                                          ),
                                          const Icon(
                                              Icons.circle_rounded,
                                              size: 40,
                                              color: Colors
                                                  .black //ColorsPallet().fetchColor(workoutNote.weekDay),
                                          ),
                                          Icon(
                                            Icons.fitness_center_rounded,
                                            size: 30,
                                            color: ColorsPallet().fetchColor(
                                                workoutNote.weekDay),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  title: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        '${workoutNote.month} ${workoutNote
                                            .day} ${workoutNote.year}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),

                                  /// Update Hive in Future Text('${workoutNote.month} ${workoutNote.day} ${workoutNote.year}'),
                                  subtitle: small == true ? Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      height: 50,
                                      // -> double tap to expand note or long press? -> single tap to reduce
                                      child: Text(workoutNote.workoutNotes,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ):
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Container(
                                      height: 150,// -> double tap to expand note or long press? -> single tap to reduce
                                      child: Text(workoutNote.workoutNotes,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),


                                  trailing: Container(
                                    width: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: const Icon(
                                              Icons.edit_note,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              showBottomSheet(
                                                  enableDrag: false,
                                                  backgroundColor: Colors.white,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(50))
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return BottomSheetWorkoutNotesEditor(
                                                      workoutNote: workoutNote,
                                                      index: index,);
                                                  });
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
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
