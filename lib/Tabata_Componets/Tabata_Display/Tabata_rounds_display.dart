import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TabataRoundsDisplay extends StatelessWidget {
  const TabataRoundsDisplay({super.key});


  @override
  Widget build(BuildContext context) {

    //late int? _rounds = BlocProvider.of<TabataBloc>(context).state.tabataModel.rounds;
    // late int? _roundsTest = BlocProvider.of<EmomBloc>(context).state.emomWorkouts?.last.rounds ?? 0;
    late int? _rounds = BlocProvider.of<TabataBloc>(context).tabataWorkouts.last.rounds;

    return BlocBuilder<TabataBloc, TabataState>
      (builder: (context,state){
      if(state.status == TabataStatus.paused){
        return Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Row(
            children: [
              Text( '${_rounds}/${state.rounds}',
                  style : GoogleFonts.bebasNeue(
                    fontSize: 40,
                    color: Colors.white,
                  )),
            ],
          ),
        );
      }
      if(state.status == TabataStatus.inProgress || state.status == TabataStatus.resting){
        return Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Row(
            children: [
              Text( '${_rounds}/${state.rounds} ',
                  style : GoogleFonts.bebasNeue(
                    fontSize: 40,
                    color: Colors.white,
                  )),
            ],
          ),
        );
      }
      if(state.status == TabataStatus.finished){
        return Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text( '${_rounds}:${state.rounds} ',
              style : GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              )),
        );
      }
      return Text(state.status.toString(), style:  TextStyle(fontSize: 20, color: Colors.white),);
    });
  }
}
