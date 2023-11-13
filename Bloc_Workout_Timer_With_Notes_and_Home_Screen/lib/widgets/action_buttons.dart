
import 'package:bloc_workout_timer_test_1/bloc/clock_bloc.dart';
import 'package:bloc_workout_timer_test_1/bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
we need to collect the total time
Total Time is the max value of break time
Starts at intial state
Then updates when you click Break+15
the problem is the value of break time updates every second
the goal, is whn you press a button we update a value to the state.breakTime that doesnt change.
 */



class ClockActions extends StatelessWidget {
  const ClockActions({super.key});

  @override
  Widget build(BuildContext context) {

    int actualBreakTime = context.select((TimerBloc bloc) => bloc.state.addBreakTime!.round() + bloc.state.breakTime.round()); // 15 + time show in break
    //int resetBreakTime = context.select((TimerBloc bloc) => bloc.initialBreakTime);

    double totalTime = context.select((TimerBloc bloc) => bloc.totalBreakTime.toDouble());
    double remainingTime = context.select((TimerBloc bloc) => bloc.state.breakTime.round()).toDouble();
    int _breakTime  = context.select((TimerBloc bloc) => bloc.breakTime);

    void values(){

      print('total-time: $totalTime');
      print('remaining Time: $remainingTime');
      print('actualBreakTime: $actualBreakTime');
    }

    values();
    //int initialAddTime = context.select((TimerBloc bloc) => bloc.state.breakTime);

    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...switch(state){
                    TimerInitial() => [
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
                            //context.read<TimerBloc>().add(BreakStared(breakTime: state.breakTime));
                          },
                          child: const Center(child: Text(
                            'break', style: TextStyle(color: Colors.white),)),
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
                                TimerStarted(duration: state.duration, breakTime: state.breakTime));
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


                    TimerRunning() => [
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
                            context.read<TimerBloc>().add(BreakStared(breakTime: _breakTime ,totalBreakTime: remainingTime.toInt()));
                          },
                          child: const Center(child: Text(
                            'break', style: TextStyle(color: Colors.white),)),
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
                            context.read<TimerBloc>().add(TimerPaused());
                          },
                          child: Center(child: Text(
                            'Pause', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                    ],


                    TimerIsPaused() => [
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
                            'break', style: TextStyle(color: Colors.white),)),
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
                                TimerStarted(duration: state.duration, breakTime: state.breakTime!));
                          },
                          child: Center(child: Text(
                            'Start', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                    ],

                  BreakTimerRunning() =>[
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
                          //int actualBreakTime = context.select((TimerBloc bloc) => bloc.state.breakTime);
                          context.read<TimerBloc>().add(BreakStared(breakTime: actualBreakTime, totalBreakTime: actualBreakTime));
                          //context.read<TimerBloc>().add(BreakStared(breakTime: state.breakTime));
                        },
                        child: const Center(child: Text(
                          'break\n + 15', style: TextStyle(color: Colors.white),)),
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
                              TimerStarted(duration: state.duration, breakTime: state.breakTime!));
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
