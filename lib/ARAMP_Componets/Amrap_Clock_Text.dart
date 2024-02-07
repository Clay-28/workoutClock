import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';


class Amrap_Clock_Text extends StatelessWidget {
  const Amrap_Clock_Text({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AMRAPBloc, AMRAPState>(
        builder: (context, state) {
          if (state.status == AMRAP_Status.initial) {
            return const Text(
              '10:00', style: TextStyle(fontSize: 40, color: Colors.white));
          }
          if (state.status == AMRAP_Status.inProgress) {
            int duration = BlocProvider.of<AMRAPBloc>(context).state.duration;
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
              style: const TextStyle(fontSize: 40, color: Colors.white),) :
            Text('$textMin:$clockSec',
              style: const TextStyle(fontSize: 40, color: Colors.white),);
          }
          if (state.status == AMRAP_Status.paused) {
            int duration = BlocProvider.of<AMRAPBloc>(context).state.duration;
            int textHour = (duration / 3600).floor();
            int textMin = ((duration / 60) % 60).floor();
            int textSec = (duration % 60).floor();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin
                .toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec
                .toString();
            return textHour >= 1 ?
            Text('$textHour:$clockMin:$clockSec',
              style: const TextStyle(fontSize: 40, color: Colors.white),) :
            Text('$textMin:$clockSec',
              style: const TextStyle(fontSize: 40, color: Colors.white),);
          }
          return Container();
        }
    );
  }
}