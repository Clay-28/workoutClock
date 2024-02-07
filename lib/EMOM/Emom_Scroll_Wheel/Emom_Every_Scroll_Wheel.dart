import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ARAMP_Componets/ARAMP_Scroll_Wheel/Amrap_Scroll_Wheel_Minutes.dart';
import 'Emom_Scroll_Wheel_Text.dart';


class EmomEveryScrollWheel extends StatelessWidget {
  const EmomEveryScrollWheel({super.key});

  @override
  Widget build(BuildContext context) {
    /// Controls the Total Height adn Width of the Scroll Wheel
    /// Because the Scroll Wheel is Horizontal -> The Width determines visibility of the

    FixedExtentScrollController everyController = BlocProvider.of<EmomBloc>(context).state.everyController;

    return Container(
        height: MediaQuery
            .of(context)
            .size
            .width * 0.15,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [

                  /// Guard Lines around Scroll Wheel
                  Container(
                    height: 35,

                    /// Test Width for Amrap Notes and Scroll Wheel
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.blue
                          )
                        )
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: ListWheelScrollView(
                        itemExtent: 150,
                        diameterRatio: 10,
                        /// Test Controller
                        /// ToDo : Created a state managed or updatable Fixed Extent Controller

                        controller: everyController,
                        physics: FixedExtentScrollPhysics(),
                        //diameterRatio: 2,
                        onSelectedItemChanged: (value) {
                          BlocProvider.of<EmomBloc>(context).add(EmomUpdate(
                              everyScrollWheelIndex: value +1,),
                          );
                        },
                        children: List.generate(20, (index) =>
                            RotatedBox(
                                quarterTurns: 1,
                                child:
                                EmomScrollWheelText(minutes: index + 1))),
                                //EmomScrollWheelText(minutes: index ))),
                        // childDelegate: ListWheelChildBuilderDelegate(
                        //     childCount: 60,
                        //     builder: (context, index) {
                        //       /// ToDo : create a
                        //       return ScrollWheelMinutes(
                        //         minutes: index + 1,
                        //       );
                        //     }
                        // )
                      ),
                    ),
                  ),
                ],
              ),
            ]
        )
    );
  }
}
