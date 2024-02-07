import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';


class Amrap_Emom_Tabata_InitialDisplay extends StatelessWidget {
  const Amrap_Emom_Tabata_InitialDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    /// Three Circle Text Buttons -> when pressed Emit a new State
    ///         AMRAP - green
    /// EMOM - Blue         TABATA - Red
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 155,
                height: 155,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.green, style: BorderStyle.solid)
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  //backgroundColor: Colors.grey,
                  fixedSize: const Size(145, 145),
                  side: BorderSide(
                    width: 3,
                    color: Colors.green
                  ),
                ),
                onPressed: () {

                  /// Sets the Clock Display to Amrap
                  BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.ARAMP));
                  /// Updates the Space between Clock Display and Slide Action Widget
                  /// With a Horizontal Scroll View With Amrap Workouts
                  BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Amramp));
                  //BlocProvider.of<MiddleAreaBloc>(context).add(UpdateState(status: MiddleAreaStatus.Clock));

                },
                child: const Center(child: Text(
                  'AMRAP', style: TextStyle(color: Colors.white, fontSize: 25),)),
              ),
            ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 155,
                    height: 155,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.blueAccent, style: BorderStyle.solid)
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      //backgroundColor: Colors.grey,
                      fixedSize: const Size(145, 145),
                      side: BorderSide(
                          width: 3,
                          color: Colors.blueAccent
                      ),
                    ),
                    onPressed: () {
                      /// Changes the WorkoutModes State and Displays Emom Initial Display
                      //BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.ARAMP));
                      BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.EMOM));
                       /// Updates the Space between Clock Display and Slide Action Widget
                      /// With a Horizontal Scroll View With Amrap Workouts
                      BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Emom));
                    },
                    child: const Center(child: Text(
                      'EMOM', style: TextStyle(color: Colors.white, fontSize: 25),)),
                  ),
                ]),
            Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 155,
                    height: 155,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.red, style: BorderStyle.solid)
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      //backgroundColor: Colors.grey,
                      fixedSize: const Size(145, 145),
                      side: BorderSide(
                          width: 3,
                          color: Colors.red
                      ),
                    ),
                    onPressed: () {
                      /// Changes WorkoutMode state and display to Tabata
                      BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.TABATA));
                    },
                    child: const Center(child: Text(
                      'TABATA', style: TextStyle(color: Colors.white, fontSize: 25),)),
                  ),
                ]),
          ],
        )
      ],
    );
  }
}
