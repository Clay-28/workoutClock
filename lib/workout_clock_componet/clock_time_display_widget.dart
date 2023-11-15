import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/clock_bloc/clock_bloc.dart';

class ClockTimeDisplay extends StatelessWidget {
  const ClockTimeDisplay({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc,TimerState>(
        builder: (context,state){
          if(state.status ==  ClockStatus.initial){
            return const Text('0:00', style: TextStyle(fontSize: 40, color: Colors.white),);
          }
          if(state.status == ClockStatus.running){
            int duration  = BlocProvider.of<TimerBloc>(context).state.duration;

            int textHour = (duration /3600).floor();
            int textMin = ((duration /60) % 60).floor();
            int textSec = (duration % 60).floor();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin.toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
            return textHour >= 1 ?
              //Text('$textHour:$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),):
              Text('$textHour:$clockMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),):
              Text('$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),);

          }
          if(state.status == ClockStatus.paused){
            int duration  = BlocProvider.of<TimerBloc>(context).state.duration;


            int textHour = (duration /3600).floor();
            int textMin = ((duration /60) % 60).floor();
            int textSec = (duration % 60).floor();
            String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin.toString();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
            return textHour >= 1 ?
            Text('$textHour:$clockMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),):
            Text('$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.white),);
          }
          if(state.status == ClockStatus.resting){
            //final duration = state.breakTime;
            int duration = BlocProvider.of<TimerBloc>(context).state.restTime;
            final textMin = ((duration /60) % 60).floor();
            final textSec = (duration % 60).floor();
            String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
            return Text('$textMin:$clockSec', style: const TextStyle(fontSize: 40, color: Colors.blueAccent),);
          }
          return Container();
        }
    );
  }
}
