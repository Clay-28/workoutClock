import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EmomIntervalClockText extends StatelessWidget {
  const EmomIntervalClockText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmomBloc, EmomState>(
        builder: (context, state) {
          if (state.status == EmomStatus.inProgress) {
            /// Original
            //int duration = BlocProvider.of<EmomBloc>(context).state.totalDuration;
            /// For Emom We User Interval Time
            int duration = BlocProvider.of<EmomBloc>(context).state.interval;
            int textHour = (duration / 3600).floor();
            int textMin = ((duration / 60) % 60).floor();
            int textSec = (duration % 60).floor();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin
                .toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec
                .toString();
            return textHour >= 1 ?
            //Text('$textHour:$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),):
            Text('$textHour:$clockMin:$clockSec',
              style: GoogleFonts.bebasNeue(
              fontSize: 50,
              color: Colors.white,
            ),) :
            Text('$textMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 50,
                color: Colors.white,
              ),);
          }
          if (state.status == EmomStatus.paused) {
            /// Original
            //int duration = BlocProvider.of<EmomBloc>(context).state.totalDuration;
            /// For Emom We User Interval Time
            int duration = BlocProvider.of<EmomBloc>(context).state.interval;
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
                fontSize: 50,
                color: Colors.white,
              ),) :
            Text('$textMin:$clockSec',
              style: GoogleFonts.bebasNeue(
                fontSize: 50,
                color: Colors.white,
              ),);
          }
          return Container();
        }
    );
  }
}


class EmomDurationClockText extends StatelessWidget {
  const EmomDurationClockText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmomBloc, EmomState>(
        builder: (context, state) {
          if (state.status == EmomStatus.inProgress) {
            /// Original
            //int duration = BlocProvider.of<EmomBloc>(context).state.totalDuration;
            /// For Emom We User Interval Time
            //int duration = BlocProvider.of<EmomBloc>(context).state.interval;
            /// Test
            int duration = BlocProvider.of<EmomBloc>(context).state.totalDuration;
            if(duration == 0 ){
              BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Emom));
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
          if (state.status == EmomStatus.paused) {
            /// Original
            int duration = BlocProvider.of<EmomBloc>(context).state.totalDuration;
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
          return Container();
        }
    );
  }
}

