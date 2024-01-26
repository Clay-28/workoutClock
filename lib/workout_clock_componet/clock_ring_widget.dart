
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';

import '../bloc/clock_bloc/clock_bloc.dart';
import 'clock_time_display_widget.dart';

class ClockRing extends StatelessWidget {
  const ClockRing({super.key});

  @override
  Widget build(BuildContext context) {

    double totalTime = context.select((TimerBloc bloc) => bloc.totalRestingTime.toDouble());
    double remainingTime = context.select((TimerBloc bloc) => bloc.state.restTime.round().toDouble());


    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state){
        return Center(
          child: Column(
            children: [
              ...switch(state.status){
              ClockStatus.initial => [
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
                    const ClockTimeDisplay(),
                    Container(
                      width: 230,
                      height: 230,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.white54, style: BorderStyle.solid)
                      ),
                    ),
                  ],
                )
              ],
                ClockStatus.running => [
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
                      ClockTimeDisplay(),
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


                ClockStatus.paused => [
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
                      const ClockTimeDisplay(),
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

                ClockStatus.resting => [
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
                          const ClockTimeDisplay(),
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
              }
            ],
          ),
        );
      }
    );
  }
}
