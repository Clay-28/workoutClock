import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';

class EmomScrollWheelText extends StatelessWidget {
  EmomScrollWheelText({super.key, required this.minutes});
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmomBloc, EmomState>
      (builder: (context, state) {
      if (state.status == EmomStatus.setup || state.emomModel.description == '') {
        /// Starting at index 0
        /// 0, 1, 2, f(index * 15 + 15)
        /// 15, 30, 45,  1min
        /// index == 0 0:15 secs
        /// 0:30, 0:45 : sec if index < 3

        int interval = BlocProvider
            .of<EmomBloc>(context)
            .state
            .interval;
        int totalDuration = BlocProvider
            .of<EmomBloc>(context)
            .state
            .totalDuration;

        if (minutes < 3) {
          return Text(
              '${(minutes * 15) + 15} secs',
              textAlign: TextAlign.center,
              style: GoogleFonts.bebasNeue(
                fontSize: 30,
                letterSpacing: 0,
                wordSpacing: 5,
                color: interval <= totalDuration ? Colors.white : Colors.red,)
          );
        }
        if (minutes >= 3 && minutes < 12) {
          int _minutes = ((minutes * 15) + 15) ~/ 60;
          int _seconds = ((minutes * 15) + 15) % 60;
          //'$_minutes:0$_seconds minutes'
          return Text(
              _seconds == 0
                  ? '$_minutes minutes'
                  : '$_minutes:$_seconds minutes',
              textAlign: TextAlign.center,
              style: GoogleFonts.bebasNeue(
                fontSize: 30,
                letterSpacing: 0,
                wordSpacing: 5,
                color: interval <= totalDuration ? Colors.white : Colors.red,)
          );
        }

        return Text(
            '${minutes - 8} minutes',
            textAlign: TextAlign.center,
            style: GoogleFonts.bebasNeue(
              fontSize: 30,
              letterSpacing: 0,
              wordSpacing: 5,
              color: interval <= totalDuration ? Colors.white : Colors.red,)
        );
      }

      if (state.status == EmomStatus.selectingWorkout || state.status == EmomStatus.helper) {

        return Text(
            '${minutes + 1} Minutes',
            textAlign: TextAlign.center,
            style: GoogleFonts.bebasNeue(
              fontSize: 30,
              letterSpacing: 0,
              wordSpacing: 5,
              color: Colors.white,)
        );
      }
      return Placeholder(
        color: Colors.pink.shade200,
        fallbackWidth: 300,
        fallbackHeight: 100,
      );
    });
  }
}
