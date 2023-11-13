import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/clock_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final textMin = ((duration/60) % 60).floor();
    //String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin.toString();
    final textSec = (duration % 60).floor();
    String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
    return Text('${textMin}:${clockSec}', style: TextStyle(fontSize: 40, color: color),);
  }
}

class BreakTimerText extends StatelessWidget {
  const BreakTimerText({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.breakTime);
    final textMin = ((duration/60) % 60).floor();
    //String clockMin = textMin < 10 ? '0${textMin.toString()}' : textMin.toString();
    final textSec = (duration % 60).floor();
    String clockSec = textSec < 10 ? '0${textSec.toString()}' : textSec.toString();
    return Text('${textMin}:${clockSec}', style: TextStyle(fontSize: 40, color: color),);
  }
}

