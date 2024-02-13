import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';

class AmrapRoundsDisplay extends StatelessWidget {
  const AmrapRoundsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AMRAPBloc, AMRAPState>
      (builder: (context,state){
        if(state.status == AMRAP_Status.paused){
          return Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdateRounds(rounds: -1));
                  print('Minus Round : ${state.rounds}');
                },
              ),
              //Text( widget.state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              //Text( BlocProvider.of<AMRAPBloc>(context).state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              Text( state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdateRounds(rounds: 1));
                  print('Minus Round : ${state.rounds}');
                },
              ),
            ],
          );
        }
        if(state.status == AMRAP_Status.inProgress || state.status == AMRAP_Status.finished){
          return Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdateRounds(rounds: -1));
                  print('Minus Round : ${state.rounds}');
                },
              ),
              //Text( widget.state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              //Text( BlocProvider.of<AMRAPBloc>(context).state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              Text( state.rounds.toString(), style: TextStyle(fontSize: 30, color: Colors.green),),
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdateRounds(rounds: 1));
                  print('Minus Round : ${state.rounds}');
                },
              ),
            ],
          );
        }
        return Text(state.status.toString(), style:  TextStyle(fontSize: 20, color: Colors.white),);
    });
  }
}
