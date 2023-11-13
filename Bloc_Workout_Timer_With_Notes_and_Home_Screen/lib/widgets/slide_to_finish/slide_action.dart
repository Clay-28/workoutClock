import 'package:bloc_workout_timer_test_1/bloc/note_bloc/note_bloc.dart';
import 'package:bloc_workout_timer_test_1/screens/workout_note_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_action/slide_action.dart';

import '../../bloc/clock_bloc.dart';
import '../../hive/models/hive_workout_note.dart';

class SlideToFinish extends StatelessWidget {
  const SlideToFinish({super.key});

  @override
  Widget build(BuildContext context) {
    String stateNotes = context.select((NoteState state) => state.text); // 15 + time show in break


    return SlideAction(
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
                    // Show loading if async operation is being performed
                    state.isPerformingAction
                        ? "Loading"
                        : "Slide to Complete", //"": ${state.thumbFractionalPosition.toStringAsPrecision(1)}",
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
                // Show loading indicator if async operation is being performed
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
            /// Send Data to FireBase including
            /// Total Time, Date, Month, Year, Notes
            /// Reset, Time, Break, Date,
            // Async operation
            var note = HiveWorkoutNotes(
              title: 'October',
              text: stateNotes
            );
            await Future.delayed(
              const Duration(seconds: 2),
                  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WorkoutNotePage()))
            );
          },
        );
  }
}

class NotesBloc {
}
