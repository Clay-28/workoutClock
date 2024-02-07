import 'dart:async';

import 'package:WorkoutClock/ARAMP_Componets/AMRAP_Display/ARAMP_Display_Componets/Amrap_finished_workout.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



import '../../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../ARAMP_Scroll_Wheel/Amrap_scroll_wheel_widget.dart';
import '../Amrap_Clock_Text.dart';
import 'ARAMP_Display_Componets/Amrap_inProgress_display.dart';
import 'ARAMP_Display_Componets/Amrap_initial_display.dart';
import 'ARAMP_Display_Componets/Amrap_paused.dart';

class ARAMPClock extends StatelessWidget {
  const ARAMPClock({super.key});

  ///  Block Builder
  ///  Initial -> Scroll Wheel For duration ->
  ///

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AMRAPBloc, AMRAPState>
      (builder: (context, state ){
        // if(state.status == AMRAP_Status.initial || state.status == AMRAP_Status.selectingWorkout) {
        //   return Amrap_initial_display(state: state);
        // }

        if(state.status == AMRAP_Status.initial) {
          return Amrap_initial_display(state: state);
        }

        if(state.status == AMRAP_Status.selectingWorkout){
          return Amrap_initial_display(state: state);
        }
        if(state.status == AMRAP_Status.helper){
          return Amrap_initial_display(state: state);
        }
        /// ------------------------ In Progress ------------------------
        if(state.status == AMRAP_Status.inProgress){
          return Amrap_inProgress_Display(state: state);
        }
        if(state.status == AMRAP_Status.paused){
          return Amrap_paused_display(state: state);
        }
        if(state.status == AMRAP_Status.finished){
          return Amrap_finished_display(state: state);
        }
        return const Text('Error Occurred, Please Refresh');
    });
  }
}

/*
return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.red,
      child: Center(
        child: IconButton(
          icon: Icon(Icons.arrow_back, size: 30,),
          onPressed: (){
            BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.initial));
          },
        ),
      ),
    );
 */

/*
Align(
                //alignment: Alignment.bottomCenter,
                child: Stack(
                    alignment: Alignment.center,
                    children:[
                      Container(
                        width: 87,
                        height: 87,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.green, style: BorderStyle.solid)
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          fixedSize: const Size(75, 75),
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          null;
                        },
                        child: Center(child: Text(
                          'Start', style: TextStyle(color: Colors.white),)),
                      ),
                    ]),
              ),
 */