import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Workout_Modes_Bloc/Modes_Bloc/modes_bloc.dart';

class InitialDisplay extends StatelessWidget {
  const InitialDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    /// Three Circle Text Buttons -> when pressed Emit a new State
    ///         AMRAP - green
    /// EMOM - Blue         TABATA - Red
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 155,
                height: 155,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.green, style: BorderStyle.solid)
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  //backgroundColor: Colors.grey,
                  fixedSize: const Size(145, 145),
                  side: BorderSide(
                    width: 3,
                    color: Colors.green
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.ARAMP));
                },
                child: const Center(child: Text(
                  'AMRAP', style: TextStyle(color: Colors.white, fontSize: 25),)),
              ),
            ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 155,
                    height: 155,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.blueAccent, style: BorderStyle.solid)
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      //backgroundColor: Colors.grey,
                      fixedSize: const Size(145, 145),
                      side: BorderSide(
                          width: 3,
                          color: Colors.blueAccent
                      ),
                    ),
                    onPressed: () {
                      null;
                    },
                    child: const Center(child: Text(
                      'EMOM', style: TextStyle(color: Colors.white, fontSize: 25),)),
                  ),
                ]),
            Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 155,
                    height: 155,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.red, style: BorderStyle.solid)
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      //backgroundColor: Colors.grey,
                      fixedSize: const Size(145, 145),
                      side: BorderSide(
                          width: 3,
                          color: Colors.red
                      ),
                    ),
                    onPressed: () {
                      null;
                    },
                    child: const Center(child: Text(
                      'TABATA', style: TextStyle(color: Colors.white, fontSize: 25),)),
                  ),
                ]),
          ],
        )
      ],
    );
  }
}
