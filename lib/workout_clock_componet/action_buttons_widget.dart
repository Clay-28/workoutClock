
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/clock_bloc/clock_bloc.dart';



class ClockActions extends StatelessWidget {
  const ClockActions({super.key});

  @override
  Widget build(BuildContext context) {

    int actualBreakTime = context.select((TimerBloc bloc) => bloc.addRestingTime + bloc.state.restTime ); // 15 + time show in break

    double totalTime = context.select((TimerBloc bloc) => bloc.totalRestingTime.toDouble());
    double remainingTime = context.select((TimerBloc bloc) => bloc.state.restTime.toDouble());
    int _breakTime  = context.select((TimerBloc bloc) => bloc.restTime);



    return BlocBuilder<TimerBloc, TimerState>(
        //buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...switch(state.status){
                      ClockStatus.initial => [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 87,
                            height: 87,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2, color: Colors.white54, style: BorderStyle.solid)
                            ),
                          ),
                          TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            fixedSize: const Size(75, 75),
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            null;
                          },
                          child: const Center(child: Text(
                            'Rest', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                      Stack(
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
                            BlocProvider.of<TimerBloc>(context).add(TimerStarted(duration: state.duration!));
                          },
                          child: Center(child: Text(
                            'Start', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                      /// Keep Notes Below, if UI Changes to 3 buttons
                      /*
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 87,
                            height: 87,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2, color: Colors.deepOrange, style: BorderStyle.solid)
                            ),
                          ),

                          TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            fixedSize: const Size(75, 75),
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            context.read<TimerBloc>().add(const TimerReset());
                            //context.read<ScrollWheelBloc>().add(CloseScrollWheel(breakMinutes: 0, breakSeconds: 10));
                            //breakSeconds: context.select((TimerBloc bloc) => bloc.initialBreakTime))
                            context.read<ScrollWheelBloc>().add(const UpdateScrollWheel(breakMinutes: 0, breakSeconds: 10));
                            //context.select((TimerBloc bloc) => bloc.initialBreakTime)
                          },
                          child: const Center(child: Text(
                            'Reset', style: TextStyle(color: Colors.white),)),
                        ),
                        ],
                      ),

                       */
                    ],
                  // TimeRunning()
                    ClockStatus.running => [
                      Stack(
                        alignment: Alignment.center,
                        children:[
                          Container(
                            width: 87,
                            height: 87,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2, color: Colors.blueAccent, style: BorderStyle.solid)
                            ),
                          ),
                          TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            fixedSize: const Size(75, 75),
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            context.read<TimerBloc>().add(BreakStared(restingTime: _breakTime,totalRestingTime: remainingTime.toInt()));
                          },
                          child: const Center(child: Text(
                            'Rest', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                      Stack(
                        alignment: Alignment.center,
                        children:[
                          Container(
                            width: 87,
                            height: 87,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2, color: Colors.redAccent, style: BorderStyle.solid)
                            ),
                          ),
                          TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            fixedSize: const Size(75, 75),
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            context.read<TimerBloc>().add(const TimerPaused());
                          },
                          child: const Center(child: Text(
                            'Pause', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                    ],
                  // TimerIsPaused
                    ClockStatus.paused => [
                      Stack(
                        alignment: Alignment.center,
                        children:[
                          Container(
                            width: 87,
                            height: 87,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2, color: Colors.white54, style: BorderStyle.solid)
                            ),
                          ),
                          TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            fixedSize: const Size(75, 75),
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            null;
                            //context.read<TimerBloc>().add(BreakStared(breakTime: 5));
                          },
                          child: const Center(child: Text(
                            'Rest', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                      Stack(
                        alignment: Alignment.center,
                        children: [
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
                            context.read<TimerBloc>().add(
                                TimerStarted(duration: state.duration!));
                          },
                          child: Center(child: Text(
                            'Start', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                    ],

                  ClockStatus.resting=>[
                    Stack(
                        alignment: Alignment.center,
                      children:[
                        Container(
                          width: 87,
                          height: 87,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: Colors.blueAccent, style: BorderStyle.solid)
                          ),
                        ),
                        TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          fixedSize: const Size(75, 75),
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          context.read<TimerBloc>().add(BreakStared(restingTime: actualBreakTime, totalRestingTime: actualBreakTime));

                        },
                        child: const Center(child: Text(
                          'Rest\n + 15', style: TextStyle(color: Colors.white),)),
                      ),
                    ]),
                    Stack(
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
                          context.read<TimerBloc>().add(
                              TimerStarted(duration: state.duration!));
                        },
                        child: Center(child: Text(
                          'Start', style: TextStyle(color: Colors.white),)),
                      ),
                    ]),
                  ],
                    _ => [],
                  }
                ],
              ),
            ),
          );
        }
    );
  }

}
