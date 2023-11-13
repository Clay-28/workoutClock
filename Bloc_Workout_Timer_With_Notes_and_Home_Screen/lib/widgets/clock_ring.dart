import 'package:bloc_workout_timer_test_1/bloc/clock_bloc.dart';
import 'package:bloc_workout_timer_test_1/widgets/timer_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
class ClockRing extends StatelessWidget {
  const ClockRing({super.key});

  @override
  Widget build(BuildContext context) {

    double totalTime = context.select((TimerBloc bloc) => bloc.totalBreakTime.toDouble());
    double remainingTime = context.select((TimerBloc bloc) => bloc.state.breakTime.round().toDouble());


    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state){
        return Center(
          child: Column(
            children: [
              ...switch(state){
              TimerInitial() => [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: const CircularCappedProgressIndicator(
                        backgroundColor: Colors.white54,
                        strokeWidth: 5.0,
                        strokeCap: StrokeCap.round,
                        value: 0,
                      ),
                    ),
                    TimerText(color: Colors.white,),
                    Container(
                      width: 230,
                      height: 230,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.black, style: BorderStyle.solid)
                      ),
                    ),
                  ],
                )
              ],

                TimerRunning() => [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: const CircularCappedProgressIndicator(
                          backgroundColor: Colors.white54,
                          strokeWidth: 5.0,
                          strokeCap: StrokeCap.round,
                          value: 1,
                          color: Colors.green,
                        ),
                      ),
                      TimerText(color: Colors.white,),
                      Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.green, style: BorderStyle.solid)
                        ),
                      ),
                    ],
                  )
                ],


                TimerIsPaused() => [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: const CircularCappedProgressIndicator(
                          backgroundColor: Colors.white54,
                          strokeWidth: 5.0,
                          strokeCap: StrokeCap.round,
                          value: 0,
                        ),
                      ),
                      TimerText(color: Colors.white,),
                      Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.redAccent, style: BorderStyle.solid)
                        ),
                      ),
                    ],
                  )
                ],


                BreakTimerRunning() => [
                  TweenAnimationBuilder(
                    tween: Tween(begin: 1, end: ((remainingTime-1)/(totalTime))),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) {
                      return Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: CircularCappedProgressIndicator(
                              backgroundColor: Colors.white54,
                              color: Colors.blueAccent,
                              strokeWidth: 5.0,
                              strokeCap: StrokeCap.round,
                              value: value+0,
                            ),
                          ),
                          BreakTimerText(color: Colors.blueAccent,),
                          Container(
                            width: 230,
                            height: 230,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2, color: Colors.blueAccent, style: BorderStyle.solid)
                            ),
                          ),
                        ],
                      );
                    }
                  )
                ],
                _ => [],
              /*
              CircularCappedProgressIndicator(
                          backgroundColor: Colors.blueAccent,
                          color: Colors.white54,
                          strokeWidth: 5.0,
                          strokeCap: StrokeCap.round,
                          value: (remainingTime/(totalTime)),
               */
              }
            ],
          ),
        );
      }
    );
  }
}
