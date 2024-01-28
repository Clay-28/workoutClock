import 'package:WorkoutClock/bloc/Workout_Modes_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/Workout_Modes_Bloc/Modes_Bloc/modes_bloc.dart';
import '../../Clock_Text.dart';

class Amrap_inProgress_Display extends StatelessWidget {
  Amrap_inProgress_Display({super.key, required this.state});

  AMRAPState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.x, size: 20, color: Colors.red,),
                        onPressed: () {

                          BlocProvider.of<AMRAPBloc>(context).add(AmrapClose());
                          BlocProvider.of<WorkoutModesBloc>(context)
                              .add(SelectWorkout(
                              status: WorkoutStatus.initial));


                        }
                    ),
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
                  Amrap_Clock_Text(),
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
                      print('Minus Round : ${AMRAPBloc.roundCount}');
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
                      print('Add Round : ${AMRAPBloc.roundCount}');
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
                            border: Border.all(width: 2, color: Colors.red, style: BorderStyle.solid)
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: const Size(75, 75),
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          BlocProvider.of<AMRAPBloc>(context).add(AmrapPause());
                          print(state.duration);
                        },
                        child: Center(child: Text(
                          'Stop', style: TextStyle(color: Colors.white),)),
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

