import 'dart:math';

import 'package:bloc_workout_timer_test_1/bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/clock_bloc.dart';
import 'scroll_wheel.dart';

class BreakTimeSelector extends StatelessWidget {
  const BreakTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScrollWheelBloc, ScrollWheelState>(
        buildWhen: (prev,state) => prev.runtimeType != state.runtimeType,
        builder: (context, state){
          return Container(
            height: 200,
            width: double.infinity,
            //color: Colors.white,
            child: Column(
              children: [
                ...switch(state){
                  ScrollWheelInitial() => [
                    Container(
                      //height: 150,
                      color: Colors.black,
                      //width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Break Time: ${state.minSelected.toString()} minutes : ${state.secondSelected} seconds',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          context.read<ScrollWheelBloc>().add(OpenScrollWheel());
                          ScrollWheel.breakMinuets = 0;
                          ScrollWheel.breakSeconds = 0;
                          },
                        child: const Text(
                          'Update Break Time',
                          style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                        )
                    )
                  ],

                ScrollWheelInProgress() => [
                  Container(
                    height: 200,
                    //width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        ScrollWheel(),
                        TextButton(
                            onPressed: (){
                              int testmin = ScrollWheel.breakMinuets;
                              int testsec = ScrollWheel.breakSeconds; //Random().nextInt(59);

                              if(testmin + testsec == 0){
                                testmin = 0;
                                testsec = 15;
                              }
                              context.read<ScrollWheelBloc>().add(CloseScrollWheel(breakMinutes: testmin, breakSeconds: testsec));
                              //int totalBreakTime = context.select((TimerState state) => state.breakTime + (min*60) + sec);
                              context.read<TimerBloc>().add(UpdateBreakTime(breakMinutes: testmin, breakSeconds: testsec));
                              print('Scroll Wheel Minutes: ${ScrollWheel.breakMinuets}');
                              print('Scroll Wheel Seconds: ${ScrollWheel.breakSeconds}');

                            },
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0,10,0,0),
                              child: Text('Update',
                                style: TextStyle(
                                  fontSize: 20
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
                      'Break Time: ${state.minSelected} minutes : ${state.secondSelected} seconds',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  TextButton(
                      onPressed: ()=> context.read<ScrollWheelBloc>().add(OpenScrollWheel()),
                      child: const Text(
                        'Update Break Time',
                        style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                      )
                  )
                ],
                _ => [],
                // ScrollWheelInitial, ScrollWheelInProgress

                }
              ],
            ),
          );
        });
  }
}
