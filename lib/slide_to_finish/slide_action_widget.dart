
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_action/slide_action.dart';

import '../bloc/clock_bloc/clock_bloc.dart';
import '../bloc/note_bloc/note_bloc.dart';
import '../models/months.dart';
import '../models/user_workout_data.dart';
import '../models/workout_data.dart';
import '../screens/user_workout_notes_page.dart';


class SlideToFinish extends StatelessWidget {
  const SlideToFinish({super.key});
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width * 0.66,
      child: SlideAction(
            trackBuilder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white54,
                ),
                child: Align(
                  alignment: state.isPerformingAction ? Alignment.center : Alignment.centerRight ,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(

                      state.isPerformingAction
                          ? "Loading"
                          : "Slide to Complete",
                    style: state.isPerformingAction ? TextStyle(color: Colors.white, fontSize: 20): TextStyle(color: Colors.white, fontSize: 20),

              ),
                  ),
                ),
              );
            },
            thumbBuilder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: state.isPerformingAction
                      ? const CupertinoActivityIndicator(
                    color: Colors.blueAccent,
                  )
                      : const Icon(
                    Icons.chevron_right,
                    color: Colors.blueAccent,
                  ),
                ),
              );
            },
            action: () async {

              int workoutTime  = BlocProvider.of<TimerBloc>(context).state.duration!;
              int workoutHours = workoutTime ~/ 3600;
              int workoutMinutes = (workoutTime ~/60) % 60;

              String calculateWorkoutMinutes(int minutes){
                if(minutes < 1){
                  return '01';
                }if(minutes < 9 && minutes >= 1){
                  return '0${minutes.toString()}';
                }
                return (minutes).toString();
              }

              String notesWorkoutMinutes = calculateWorkoutMinutes(workoutMinutes);

              String notes = 'Workout Time: $workoutHours:$notesWorkoutMinutes\n${BlocProvider.of<NoteBloc>(context).state.text}';



              BlocProvider.of<NoteBloc>(context).userData.addWorkoutNote(notes, workoutTime);

              //BlocProvider.of<NoteBloc>(context).userData.closeHive();

              BlocProvider.of<TimerBloc>(context).add(const TimerReset());
              await Future.delayed(
                const Duration(seconds: 1),
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserWorkoutNotesPage()
                      ));
                      //String text = context.select((NoteState state) => state.text);
                    }
              );
            },
          ),
    );
  }
}

