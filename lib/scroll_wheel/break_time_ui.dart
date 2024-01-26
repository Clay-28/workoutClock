import 'dart:math';

import 'package:WorkoutClock/slide_to_finish/slide_action_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/clock_bloc/clock_bloc.dart';
import '../bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'scroll_wheel_widget.dart';

class BreakTimeSelector extends StatelessWidget {
  const BreakTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrollWheelBloc, ScrollWheelState>(
        buildWhen: (prev,state) => prev.runtimeType != state.runtimeType,
        builder: (context, state){
          return Container(
            //height: state.runtimeType == ScrollWheelVanish ? 0 : 220,
            height: 220,
            color: Colors.black,
            width: double.infinity,
            // //color: Colors.white,
            child: Column(
              children: [
                ...switch(state){

                  ScrollWheelInitial() => [
                    Container(
                      //height: 150,
                      color: Colors.black,
                      child: Text(
                        'Rest Time: ${state.minSelected.toString()} minutes : ${state.secondSelected} seconds',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          context.read<ScrollWheelBloc>().add(OpenScrollWheel());
                          // ScrollWheel.breakMinuets = 0;
                          // ScrollWheel.breakSeconds = 0;
                          },
                        child: const Text(
                          'Update Rest Time',
                          style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                        )
                    )
                  ],

                ScrollWheelInProgress() => [
                  Container(
                    height: 220,
                    //width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        ScrollWheel(),
                        TextButton(
                            onPressed: (){
                              int breakMinutes = ScrollWheel.breakMinuets;
                              int breakSeconds = ScrollWheel.breakSeconds;
                              if(breakMinutes + breakSeconds == 0){
                                breakMinutes = ScrollWheelBloc.breakminutes;
                                breakSeconds = ScrollWheelBloc.breakseconds;
                              }
                              context.read<ScrollWheelBloc>().add(CloseScrollWheel(breakMinutes: breakMinutes, breakSeconds: breakSeconds));
                              BlocProvider.of<TimerBloc>(context).add(UpdateBreakTime(restMinutes: breakMinutes, restSeconds: breakSeconds));
                              ScrollWheelBloc.breakminutes = breakMinutes;
                              ScrollWheelBloc.breakseconds = breakSeconds;

                            },
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0,10,0,0),
                              child: Text('Update',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueAccent
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],

                ScrollWheelUpdate() =>[
                  Container(
                    //height: 150,
                    //color: Colors.blueAccent,
                    //width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Rest Time: ${state.minSelected} minutes : ${state.secondSelected} seconds',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  TextButton(
                      onPressed: ()=>context.read<ScrollWheelBloc>().add(OpenScrollWheel()),
                      child: const Text(
                        'Update Rest Time',
                        style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                      )
                  )
                ],

                ScrollWheelVanish() => [ ],

                _ => [],
                // ScrollWheelInitial, ScrollWheelInProgress

                }
              ],
            ),
          );
        });
  }
}
