import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/middle_area_bloc/middle_area_bloc.dart';

class TabataClockText extends StatelessWidget {
  const TabataClockText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabataBloc, TabataState>(
        builder: (context, state) {
          //int restDuration = BlocProvider.of<TabataBloc>(context).state.restInterval - 1;

          if (state.status == TabataStatus.inProgress) {
            /// Test
            int duration = BlocProvider
                .of<TabataBloc>(context)
                .state
                .interval;
            int textHour = (duration / 3600).floor();
            final textMin = ((duration / 60) % 60).floor();
            final textSec = (duration % 60).floor();
            //String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin
                .toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec
                .toString();
            return textHour >= 1 ?
            //Text('$textHour:$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),):
            Text('$textHour:$clockMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),) :
            Text('$textMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),);
          }
          if (state.status == TabataStatus.paused) {
            /// Add a bool to change from interval to rest interval
            /// Original
            int duration = BlocProvider
                .of<TabataBloc>(context)
                .state
                .interval;

            /// For Emom We User Interval Time
            //int duration = BlocProvider.of<EmomBloc>(context).state.interval;
            int textHour = (duration / 3600).floor();
            int textMin = ((duration / 60) % 60).floor();
            int textSec = (duration % 60).floor();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin
                .toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec
                .toString();
            return textHour >= 1 ?
            Text('$textHour:$clockMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),) :
            Text('$textMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),);
          }
          if (state.status == TabataStatus.resting) {
            if (state.tabataModel.rounds == 0 &&
                state.tabataModel.restInterval == state.restInterval) {
              return Text('0:0${state.tabataModel.restInterval - 1}',
                style: GoogleFonts.bebasNeue(
                  fontSize: 40,
                  color: Colors.white,
                ),);
            }

            /// Test
            int restDuration = BlocProvider
                .of<TabataBloc>(context)
                .state
                .restInterval;
            int textHour = (restDuration / 3600).floor();
            final textMin = ((restDuration / 60) % 60).floor();
            final textSec = (restDuration % 60).floor();
            //String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin
                .toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec
                .toString();
            return textHour >= 1 ?
            //Text('$textHour:$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),):
            Text('$textHour:$clockMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),) :
            Text('$textMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),);
          }

          return Container();
        }
    );
  }
}


class TabataTotalDurationClockText extends StatelessWidget {
  const TabataTotalDurationClockText ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabataBloc, TabataState>(
        builder: (context, state) {
          if (state.status == TabataStatus.inProgress) {
            /// Test
            int duration = BlocProvider.of<TabataBloc>(context).state.totalDuration;
            if(duration == 0 ){
              BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Invisible));
            }
            int textHour = (duration / 3600).floor();
            final textMin = ((duration /60) % 60).floor();
            final textSec = (duration % 60).floor();
            //String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin
                .toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec
                .toString();
            return textHour >= 1 ?
            //Text('$textHour:$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),):
            Text('$textHour:$clockMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),) :
            Text('$textMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),);
          }
          if (state.status == TabataStatus.paused) {
            /// Add a bool to change from interval to rest interval
            /// Original
            int duration = BlocProvider.of<TabataBloc>(context).state.totalDuration;
            /// For Emom We User Interval Time
            //int duration = BlocProvider.of<EmomBloc>(context).state.interval;
            int textHour = (duration / 3600).floor();
            int textMin = ((duration / 60) % 60).floor();
            int textSec = (duration % 60).floor();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin
                .toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec
                .toString();
            return textHour >= 1 ?
            Text('$textHour:$clockMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),) :
            Text('$textMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),);
          }

          if(state.status == TabataStatus.resting){
              int duration = BlocProvider.of<TabataBloc>(context).state.totalDuration;
            int textHour = (duration / 3600).floor();
            final textMin = ((duration /60) % 60).floor();
            final textSec = (duration % 60).floor();
            //String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin
                .toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec
                .toString();
            return textHour >= 1 ?
            //Text('$textHour:$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),):
            Text('$textHour:$clockMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),) :
            Text('$textMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),);
          }
          return Container();
        }
    );
  }
}