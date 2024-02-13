import 'package:WorkoutClock/EMOM/Emom_Top_Display/Emom_Display_Builder.dart';
import 'package:WorkoutClock/screens/Workout_Modes/Amrap_Emom_Tabata_initial_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ARAMP_Componets/AMRAP_Display/ARAMP_Clock_Display.dart';
import '../../Tabata_Componets/Tabata_Display/Tabata_Display_Builder.dart';
import '../../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';



class SelectWorkoutMode extends StatelessWidget {
  const SelectWorkoutMode({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutModesBloc, WorkoutModeState>(
      builder: (context, state) {
        if(state.status == WorkoutStatus.initial){
          //const Center(child: Text('Initial: Test 2', style: TextStyle(color: Colors.blueAccent, fontSize: 35),),);
          return const Amrap_Emom_Tabata_InitialDisplay();
        }
        if(state.status == WorkoutStatus.ARAMP){
          return const ARAMPClock();
        }
        if(state.status == WorkoutStatus.EMOM){
          return const EmomDisplayBuilder();
        }
        if(state.status == WorkoutStatus.TABATA){
          return const TabataDisplayBuilder();
        }
        return const Center(child: Text('Error, Please Refresh', style: TextStyle(color: Colors.blueAccent, fontSize: 35),),);
    },
    );
  }
}

// MultiBlocProvider(
//       providers: [
//         BlocProvider<TimerBloc>(
//         create: (BuildContext context) => TimerBloc(ticker: const Ticker()),
//       ),
