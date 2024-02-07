import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';

class EmomForScrollWheelText extends StatelessWidget {
  const EmomForScrollWheelText({super.key, required this.minutes});

  final int minutes;


  @override
  Widget build(BuildContext context) {
    /// Starting at index 0
    /// 1 , 1:30, 2, 2 :30

    int interval = BlocProvider.of<EmomBloc>(context).state.interval;
    int totalDuration = BlocProvider.of<EmomBloc>(context).state.totalDuration;

    var testText = BlocProvider.of<EmomBloc>(context).forScrollWheelText;

    return Text(
              '${testText[minutes]?.first.toString().split(' ').first} minutes',
              textAlign: TextAlign.center,
              style: GoogleFonts.bebasNeue(
                fontSize: 30,
                letterSpacing: 0,
                wordSpacing: 5,
                color: Colors.white,)
          );

    // if(minutes == 1){
    //   return Text(
    //       '1 min',
    //       textAlign: TextAlign.center,
    //       style: GoogleFonts.bebasNeue(
    //         fontSize: 30,
    //         letterSpacing: 0,
    //         wordSpacing: 5,
    //         color: Colors.white,)
    //   );
    // }
    //
    // if(minutes % 2 == 0){
    //   return Text(
    //       '${minutes ~/2}:30 minutes',
    //       textAlign: TextAlign.center,
    //       style: GoogleFonts.bebasNeue(
    //         fontSize: 30,
    //         letterSpacing: 0,
    //         wordSpacing: 5,
    //         color: interval <= totalDuration ? Colors.white : Colors.red)
    //   );
    // }
    // return Text(
    //     '${(minutes ~/2) + 1} minutes',
    //     textAlign: TextAlign.center,
    //     style: GoogleFonts.bebasNeue(
    //       fontSize: 30,
    //       letterSpacing: 0,
    //       wordSpacing: 5,
    //       color: interval <= totalDuration ? Colors.white : Colors.red)
    // );
  }
}
