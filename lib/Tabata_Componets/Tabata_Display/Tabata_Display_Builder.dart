import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import 'Tabata_finished_display.dart';
import 'Tabata_inProgress_display.dart';
import 'Tabata_paused_display.dart';
import 'Tabata_resting_display.dart';
import 'Tabata_set-up_display.dart';

class TabataDisplayBuilder extends StatelessWidget {
   const TabataDisplayBuilder ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabataBloc,TabataState>
      (builder: (context,state){
        if(state.status == TabataStatus.setup){
          return TabataSetUpDisplay();
        }
        if(state.status == TabataStatus.selectingWorkout){
          return TabataSetUpDisplay();
        }
        if(state.status == TabataStatus.paused){
          return TabataPausedDisplay();
        }if(state.status == TabataStatus.inProgress){
          return TabataInProgressDisplay(state: state,);
        }if(state.status == TabataStatus.resting){
          return TabataRestingDisplay(state:state);
        }if(state.status == TabataStatus.finished){
          return TabataFinishedDisplay();
        }
        return const Placeholder(
          fallbackHeight: 200,
          fallbackWidth: 300,
          color: Colors.pink,
        );
    });
  }
}

