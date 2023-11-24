
import 'package:WorkoutClock/bloc/clock_bloc/clock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc/note_bloc.dart';
import '../bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import '../items/ticks.dart';
import '../scroll_wheel/break_time_ui.dart';
import '../slide_to_finish/slide_action_widget.dart';
import '../workout_clock_componet/action_buttons_widget.dart';
import '../workout_clock_componet/clock_ring_widget.dart';
import '../workout_notes/workout_notes.dart';


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
          create: (BuildContext context) => NoteBloc()..add(RegisterHiveEvent()),
        )
        ],
        child: WillPopScope(
          onWillPop: () async => false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0,50,0,0),
            child: SingleChildScrollView(
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
                      SlideToFinish(),
                      WorkoutNotes(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
