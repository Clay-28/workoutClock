import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Workout_Modes_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../bloc/Workout_Modes_Bloc/Modes_Bloc/modes_bloc.dart';

class ARAMPClock extends StatelessWidget {
  const ARAMPClock({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_upward,
                        size: 30,
                      ),
                      onPressed: () {
                        BlocProvider.of<WorkoutModesBloc>(context)
                            .add(SelectWorkout(status: WorkoutStatus.initial));
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.center,
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
                    //const ClockTimeDisplay(),
                    Text('0:00', style: TextStyle(fontSize: 40, color: Colors.white),),
                    Container(
                      width: 230,
                      height: 230,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2,
                              color: Colors.white54,
                              style: BorderStyle.solid)),
                    )
                  ],
                ),
              ),

            ],
          ),
          Stack(
            children: [
              Container(
                height : 87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        BlocProvider.of<AMRAPBloc>(context).subtractRound();
                        print('Minus Round : ${AMRAPBloc.testCount}');
                      },
                    ),
                    Text('Data', style: TextStyle(fontSize: 25, color: Colors.green),),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        BlocProvider.of<AMRAPBloc>(context).addRound();
                        print('Add Round : ${AMRAPBloc.testCount}');
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
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
              ),
            ],
          )
        ],
      );
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