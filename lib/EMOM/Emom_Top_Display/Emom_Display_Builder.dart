import 'package:WorkoutClock/EMOM/Emom_Top_Display/Emom_initial_display.dart';
import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ARAMP_Componets/AMRAP_Display/ARAMP_Display_Componets/Amrap_initial_display.dart';
import '../../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import 'Emom_Selecting_Workout.dart';

class EmomDisplayBuilder extends StatelessWidget {
  const EmomDisplayBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmomBloc, EmomState>
      (builder: (context, state ){
      // if(state.status == AMRAP_Status.initial || state.status == AMRAP_Status.selectingWorkout) {
      //   return Amrap_initial_display(state: state);
      //
      if(state.status == EmomStatus.setup) {
        return EmomInitialDisplay();
      }
      if(state.status == EmomStatus.selectingWorkout){
        return EmomSelectingWorkout();
      }if(state.status == EmomStatus.helper){
        return EmomInitialDisplay();
      }

      return const Text('Error Occurred, Please Refresh');
    });
  }
}
