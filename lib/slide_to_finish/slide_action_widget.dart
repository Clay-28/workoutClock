
import 'package:WorkoutClock/ARAMP_Componets/AMRAP_model.dart';
import 'package:WorkoutClock/bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_action/slide_action.dart';

import '../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import '../bloc/clock_bloc/clock_bloc.dart';
import '../bloc/middle_area_bloc/middle_area_bloc.dart';
import '../bloc/note_bloc/note_bloc.dart';
import '../models/Quotes_Clock_Workouts.dart';
import '../models/months.dart';
import '../models/user_workout_data.dart';
import '../models/workout_data.dart';
import '../screens/user_workout_notes_page.dart';


class SlideToFinish extends StatelessWidget {
  const SlideToFinish({super.key});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
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





                //BlocProvider.of<ScrollWheelBloc>(context).add(CloseScrollWheel(breakMinutes: 1, breakSeconds: 30));
                /// Resets Scroll Wheel Bloc and UI
                BlocProvider.of<ScrollWheelBloc>(context).add(UpdateScrollWheel(breakMinutes: 1, breakSeconds: 30));

                /// Updates Center Blue Dot
                const QuotesClockWorkouts().setCurrentPosition(index: 1);

                /// Adds Workout Notes to hive
                String AmrapTotalNotes = BlocProvider.of<AMRAPBloc>(context).fetchTotalAmrapData();
                String notesWorkoutMinutes = calculateWorkoutMinutes(workoutMinutes);
                String notes = 'Workout Time: $workoutHours:$notesWorkoutMinutes\n${BlocProvider.of<NoteBloc>(context).state.controller.text}'
                    '\n\n\n$AmrapTotalNotes';
                BlocProvider.of<NoteBloc>(context).userData.addWorkoutNote(notes, workoutTime);

                /// Resets Timer Bloc
                BlocProvider.of<TimerBloc>(context).add(TimerReset());

                /// Resets the user notes
                BlocProvider.of<NoteBloc>(context).add(UpdateNotes(text: 'Workout Notes:\n'));
                BlocProvider.of<TimerBloc>(context).add(const TimerReset());

                /// Resets AMRAP Notes
                BlocProvider.of<AMRAPBloc>(context).AmrapReset();
                BlocProvider.of<AMRAPBloc>(context).add(AmrapClose());

                /// Resets Middle Area Bloc
                BlocProvider.of<MiddleAreaBloc>(context).add(ResetMiddleArea(status: MiddleAreaStatus.Clock));

                /// Sets Amrap, Emom, Tatbata Display
                BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.initial));


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
      ),
    );
  }
}

