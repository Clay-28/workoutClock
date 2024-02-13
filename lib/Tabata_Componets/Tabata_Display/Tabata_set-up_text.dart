import 'dart:math';

import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:WorkoutClock/bloc/note_bloc/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import '../../models/Quotes_Clock_Workouts.dart';
import '../Tabata_Scroll_Wheel/Tabata_rounds_scroll_wheel.dart';
import '../Tabata_Scroll_Wheel/Tabata_work_n_rest_scroll_wheel.dart';


class TabataSetUpText extends StatefulWidget {
  TabataSetUpText({super.key});

  @override
  State<TabataSetUpText> createState() => _TabataSetUpTextState();
}

class _TabataSetUpTextState extends State<TabataSetUpText> {
  // String? everyText = BlocProvider.of<EmomBloc>(context).state.everyScrollText;
  @override
  Widget build(BuildContext context) {

    FixedExtentScrollController roundController = BlocProvider.of<TabataBloc>(context).state.roundController;
    FixedExtentScrollController workController = BlocProvider.of<TabataBloc>(context).state.durationController;
    FixedExtentScrollController restController = BlocProvider.of<TabataBloc>(context).state.restController;

    return Container(
      width: MediaQuery.of(context).size.width * 0.72,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Tabata', style: GoogleFonts.bebasNeue(
              fontSize: 30,
              color: Colors.white)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Rounds ', style: GoogleFonts.bebasNeue(
                fontSize: 30,
                color: Colors.white,)
              ),
              TabataRoundScrollWheel(totalItems: 101, scrollController: roundController)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Work' ,style: GoogleFonts.bebasNeue(
                fontSize: 30,
                color: Colors.white,)
              ),
              TabataWorkRestScrollWheel(totalItems: 150, scrollController: workController, restInterval: false,)
            ],
          ),
          /// Every Horizontal Scroll Wheel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Rest', style: GoogleFonts.bebasNeue(
                fontSize: 30,
                color: Colors.white,)
              ),
              // ToDo: scrollController will be controlled by the state
              TabataWorkRestScrollWheel(totalItems: 99, scrollController: restController, restInterval: true,)
            ],
          ),
          /// For with Horizontal Scroll Wheel
          TextButton(
              onPressed: (){
                print('touched');
                /// Updates Tabata State
                BlocProvider.of<TabataBloc>(context).add(UpdateTabata(status: TabataStatus.paused));
                /// Creates a emomModel, updates the state.emomModel and it to TabataWorkout list
                BlocProvider.of<TabataBloc>(context).add(CreateTabataWorkout());
                BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Tabata));
                /// Updates Quotes_Clock_Workouts Page
                BlocProvider.of<NoteBloc>(context).state.copyWith(locked: true);
                QuotesClockWorkouts().setCurrentPosition(index: 0);
              },
              child: Text('Start' ,style: GoogleFonts.bebasNeue(
                fontSize: 30,
                color: Colors.white,)
              ),
          )
        ],
      ),
    );
  }
}
