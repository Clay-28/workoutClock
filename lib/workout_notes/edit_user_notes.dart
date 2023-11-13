import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/user_note_bloc/user_notes_bloc.dart';
import '../models/user_workout_data.dart';

class BottomSheetWorkoutNotesEditor extends StatelessWidget {
  BottomSheetWorkoutNotesEditor({super.key, required this.workoutNote, required this.index});
  late int index;
  late UserWorkoutNotes workoutNote;

  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController(text: workoutNote.workoutNotes);

    return Container(
      //color: Colors.black,
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.blueAccent, width: 3, style: BorderStyle.solid),
          color: Colors.black
      ),
      //color: Colors.white54,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            child: Center(
              child: Text('${workoutNote.month} ${workoutNote.day} ${workoutNote.year}',
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
              height: MediaQuery.of(context).size.height * 0.33,
              child: TextField(
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
                  fontSize: 20
                  ,
                  color: Colors.blueAccent,
                  height: 1.5,
                  wordSpacing: 0.1,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: ()  {


              BlocProvider.of<UserNotesBloc>(context).add(EditWorkoutNote(userWorkoutNotes:
              UserWorkoutNotes(
                  workoutNotes: controller.text,
                  day: workoutNote.day,
                  year: workoutNote.year,
                  weekDay: workoutNote.weekDay,
                  month: workoutNote.month,
                  workoutTime: workoutNote.workoutTime),
                  index: index));
              print(controller.text);
              print(index);
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
