import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/Workout_Modes_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../../../bloc/Workout_Modes_Bloc/Modes_Bloc/modes_bloc.dart';
import '../../ARAMP_Scroll_Wheel/Amrap_scroll_wheel_widget.dart';


class Amrap_initial_display extends StatelessWidget {
  Amrap_initial_display({super.key, required this.state});

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
                      icon: FaIcon(
                        FontAwesomeIcons.x, size: 20, color: Colors.red,),
                      onPressed: () {
                        //state.copyWith(status: AMRAP_Status.initial);
                        BlocProvider.of<WorkoutModesBloc>(context)
                            .add(
                            SelectWorkout(status: WorkoutStatus.initial));
                      },
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.35,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Colors.green,
                            style: BorderStyle.solid
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                            Radius.circular(25))
                    ),
                  ),
                  //const ClockTimeDisplay(),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.65,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.33,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            color: Colors.green,
                            style: BorderStyle.solid
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                            Radius.circular(25))
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('AMRAP', style: TextStyle(
                          fontSize: 30, color: Colors.white),),
                      Text('As Many Rounds As Possible', style: TextStyle(
                          fontSize: 15, color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: AmrapScrollWheel(),
                      ),
                      TextButton(
                        onPressed: () {
                          int duration = AmrapScrollWheel.duration;
                          BlocProvider.of<AMRAPBloc>(context).add(
                              AmrapUpdate(duration: duration, status: AMRAP_Status.paused));
                        },
                        child: Text('Start', style: TextStyle(
                            fontSize: 30, color: Colors.white),),)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
