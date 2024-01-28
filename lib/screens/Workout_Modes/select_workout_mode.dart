import 'package:WorkoutClock/bloc/Workout_Modes_Bloc/Modes_Bloc/modes_bloc.dart';
import 'package:WorkoutClock/models/clock_display.dart';
import 'package:WorkoutClock/screens/Workout_Modes/initial_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ARAMP_Componets/AMRAP_Display/ARAMP_Clock_Display.dart';
import '../../bloc/Workout_Modes_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';



class SelectWorkoutMode extends StatelessWidget {
  const SelectWorkoutMode({super.key});



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:[
          BlocProvider<WorkoutModesBloc>(
          create: (BuildContext context) => WorkoutModesBloc()),
          BlocProvider<AMRAPBloc>(
              create: (BuildContext context) => AMRAPBloc())
        ],
        child:
        /// Visual representation of Workout Modes
        /// States, Initial, ARAMP, EMOM, TABTA
        BlocBuilder<WorkoutModesBloc, WorkoutModeState>(
          builder: (context, state) {
            if(state.status == WorkoutStatus.initial){
              //const Center(child: Text('Initial: Test 2', style: TextStyle(color: Colors.blueAccent, fontSize: 35),),);
              return InitialDisplay();
            }
            if(state.status == WorkoutStatus.ARAMP){
              return const ARAMPClock();
            }
            return const Center(child: Text('Error, Please Refresh', style: TextStyle(color: Colors.blueAccent, fontSize: 35),),);
        },
        )
    );
  }
}

// MultiBlocProvider(
//       providers: [
//         BlocProvider<TimerBloc>(
//         create: (BuildContext context) => TimerBloc(ticker: const Ticker()),
//       ),
