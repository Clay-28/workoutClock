import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EmomRoundsDisplay extends StatelessWidget {
  const EmomRoundsDisplay({super.key});

  @override
  Widget build(BuildContext context) {

    late int? _rounds = BlocProvider.of<EmomBloc>(context).state.emomModel.rounds;
    // late int? _roundsTest = BlocProvider.of<EmomBloc>(context).state.emomWorkouts?.last.rounds ?? 0;
    late int? _roundsTest = BlocProvider.of<EmomBloc>(context).emomWorkoutList.last.rounds;

    return BlocBuilder<EmomBloc, EmomState>
      (builder: (context,state){
      if(state.status == EmomStatus.paused){
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              // IconButton(
              //   icon: Icon(
              //     Icons.remove,
              //     size: 30,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     // BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdateRounds(rounds: -1));
              //     // print('Minus Round : ${state.rounds}');
              //   },
              // ),
              //Text( widget.state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              //Text( BlocProvider.of<AMRAPBloc>(context).state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              Text( '${_rounds}:${_roundsTest}/${state.emomModel.totalDuration! ~/ state.emomModel.interval!} ',
                style : GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              )),
              // IconButton(
              //   icon: Icon(
              //     Icons.add,
              //     size: 30,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     // BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdateRounds(rounds: 1));
              //     // print('Minus Round : ${state.rounds}');
              //   },
              // ),
            ],
          ),
        );
      }
      if(state.status == EmomStatus.inProgress){
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              // IconButton(
              //   icon: Icon(
              //     Icons.remove,
              //     size: 30,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     // BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdateRounds(rounds: -1));
              //     // print('Minus Round : ${state.rounds}');
              //   },
              // ),
              //Text( widget.state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              //Text( BlocProvider.of<AMRAPBloc>(context).state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              Text( '${_rounds}:${_roundsTest}/${state.emomModel.totalDuration! ~/ state.emomModel.interval!} ',
                  style : GoogleFonts.bebasNeue(
                    fontSize: 40,
                    color: Colors.white,
                  )),
              // IconButton(
              //   icon: Icon(
              //     Icons.add,
              //     size: 30,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     // BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdateRounds(rounds: 1));
              //     // print('Minus Round : ${state.rounds}');
              //   },
              // ),
            ],
          ),
        );
      }
      if(state.status == EmomStatus.finished){
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text( '${_rounds}:${_roundsTest}/${state.emomModel.totalDuration! ~/ state.emomModel.interval!} ',
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
