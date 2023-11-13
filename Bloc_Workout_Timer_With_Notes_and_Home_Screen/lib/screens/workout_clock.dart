import 'package:bloc_workout_timer_test_1/bloc/clock_bloc.dart';
import 'package:bloc_workout_timer_test_1/bloc/note_bloc/note_bloc.dart';
import 'package:bloc_workout_timer_test_1/bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'package:bloc_workout_timer_test_1/widgets/scroll_wheel/break_time_ui.dart';
import 'package:bloc_workout_timer_test_1/widgets/workout_Notes/workout_notes_2.dart';
import 'package:flutter/material.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import '../items/ticks.dart';
import '../widgets/action_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/clock_ring.dart';
import '../widgets/slide_to_finish/slide_action.dart';
import '../widgets/timer_text.dart';
import '../widgets/workout_Notes/workout_notes.dart';

class WorkoutClock extends StatelessWidget {
  const WorkoutClock({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
        child: WillPopScope(
          onWillPop: () async => false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0,50,0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClockRing(),
                    //TimerText(color: Colors.white54,),
                  ],
                ),
                ClockActions(),
                BreakTimeSelector(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: SlideToFinish(), flex:2),
                    Expanded(child: WorkoutNotes2()),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
