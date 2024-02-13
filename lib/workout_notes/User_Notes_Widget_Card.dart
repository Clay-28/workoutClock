import 'package:WorkoutClock/models/user_workout_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/user_note_bloc/user_notes_bloc.dart';
import '../services/colors.dart';
import 'edit_user_notes.dart';

class UserNotesCard extends StatefulWidget {
  UserNotesCard({super.key, required this.index, required this.workoutNote});

  int index;
  UserWorkoutNotes workoutNote;
  @override
  State<UserNotesCard> createState() => _UserNotesCardState();
}

class _UserNotesCardState extends State<UserNotesCard> {

  bool small = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          small = !small;
        });
      },
      child: Slidable(
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
                      DeleteWorkoutNote(index: widget.index));
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
              color: Colors.white10,
              borderRadius: BorderRadius.all(
                  Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.white10,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white10,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          width: double.infinity,
          child: ListTile(
            leading: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment
                    .center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                          Icons.circle_rounded,
                          size: 46,
                          color: Colors
                              .white //ColorsPallet().fetchColor(workoutNote.weekDay),
                      ),
                      const Icon(
                          Icons.circle_rounded,
                          size: 42,
                          color: Colors
                              .black //ColorsPallet().fetchColor(workoutNote.weekDay),
                      ),
                      Icon(
                        Icons.fitness_center_rounded,
                        size: 30,
                        color: ColorsPallet().fetchColor(
                            widget.workoutNote.weekDay),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '${widget.workoutNote.month} ${widget.workoutNote
                      .day} ${widget.workoutNote.year}',
                  style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  letterSpacing: 1.0,
                  color: Colors.white,
                ),
                ),
              ),
            ),

            /// Update Hive in Future Text('${workoutNote.month} ${workoutNote.day} ${workoutNote.year}'),
            subtitle: small == true ? Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: 60,
                // -> double tap to expand note or long press? -> single tap to reduce
                child: Text(widget.workoutNote.workoutNotes,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  textAlign: TextAlign.center,
                ),
              ),
            ):
            /// Larger Card When Widget is Tapped
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,// -> double tap to expand note or long press? -> single tap to reduce
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(widget.workoutNote.workoutNotes,
                        style: GoogleFonts.bebasNeue(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ),
            ),

            trailing: Container(
              height: 50,
              width: 60,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: MaterialButton(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      const Icon(
                        Icons.edit_note,
                        color: Colors.black,
                        size: 30,
                      ),
                    ],
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
                            workoutNote: widget.workoutNote,
                            index: widget.index,);
                        });
                  }),
            ),
          ),
        ),
      )
    );
  }
}
