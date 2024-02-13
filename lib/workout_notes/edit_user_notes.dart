import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/user_note_bloc/user_notes_bloc.dart';
import '../models/user_workout_data.dart';

class BottomSheetWorkoutNotesEditor extends StatefulWidget {

  BottomSheetWorkoutNotesEditor({super.key, required this.workoutNote, required this.index});
  late int index;
  late UserWorkoutNotes workoutNote;

  @override
  State<BottomSheetWorkoutNotesEditor> createState() => _BottomSheetWorkoutNotesEditorState();
}

class _BottomSheetWorkoutNotesEditorState extends State<BottomSheetWorkoutNotesEditor> {


  ScrollController scrollController = ScrollController(initialScrollOffset: 0.0);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }




  @override
  Widget build(BuildContext context) {

    // ScrollController scrollController = ScrollController();

    Future.delayed(Duration(milliseconds: 100), (){
      scrollController.jumpTo(0.0);
      //scrollController.animateTo(0.0, duration: Duration(milliseconds: 100), curve: Curves.linear);
    });
    TextEditingController controller = TextEditingController(text: widget.workoutNote.workoutNotes);
    controller.selection.end;




    //ScrollController scrollController = ScrollController(initialScrollOffset: 0.0);

    return Container(
      //color: Colors.black,
      height: MediaQuery.of(context).size.height * 0.47,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top:Radius.circular(50)),
          border: Border.all(color: Colors.blueAccent, width: 3, style: BorderStyle.solid),
          color: Colors.black
      ),
      //color: Colors.white54,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            child: Center(
              child: Text('${widget.workoutNote.month} ${widget.workoutNote.day} ${widget.workoutNote.year}',
                style: GoogleFonts.spaceMono(
                    fontSize: 20,
                    color: Colors.blueAccent
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child : Container(
              height: MediaQuery.of(context).size.height * 0.30,
              child: TextField(
                scrollController: scrollController,
                autofocus: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),

                controller: controller,
                maxLines: 20,
                style: GoogleFonts.spaceMono(
                  fontSize: 16
                  ,
                  color: Colors.white,
                  height: 1.5,
                  wordSpacing: 0.1,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: ()  {

              //scrollController.jumpTo(0.0, duration: Duration(seconds: 1), curve: Curves.linear);

              scrollController = ScrollController(initialScrollOffset: 0.0);
              BlocProvider.of<UserNotesBloc>(context).add(EditWorkoutNote(userWorkoutNotes:
              UserWorkoutNotes(
                  workoutNotes: controller.text,
                  day: widget.workoutNote.day,
                  year: widget.workoutNote.year,
                  weekDay: widget.workoutNote.weekDay,
                  month: widget.workoutNote.month,
                  workoutTime: widget.workoutNote.workoutTime),
                  index: widget.index));
             Navigator.pop(context);
              //BlocProvider.of<UserNotesBloc>(context).add(EditWorkoutNote(notes: controller.text, index: index));

            },
            child: const Text('Update',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent
              ),
            ),
          )
        ],
      ),
    );
  }
}
