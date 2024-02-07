import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ARAMP_Componets/ARAMP_Scroll_Wheel/Amrap_Scroll_Wheel_Minutes.dart';
import 'Emom_For_Scroll_Wheel_Text.dart';
import 'Emom_Scroll_Wheel_Text.dart';


class EmomForScrollWheel extends StatelessWidget {
  const EmomForScrollWheel({super.key});



  @override
  Widget build(BuildContext context) {

    // FixedExtentScrollController forController = BlocProvider.of<EmomBloc>(context).state.forController;

    return BlocBuilder<EmomBloc,EmomState>(
      builder: (context, state){
        if(state.status == EmomStatus.setup){
          int forIndex = BlocProvider.of<EmomBloc>(context).state.forScrollWheelIndex!;
          print('forIndex : $forIndex');
          return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.12,
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
                              controller: FixedExtentScrollController(initialItem: forIndex),
                              physics: FixedExtentScrollPhysics(),
                              //diameterRatio: 2,
                              onSelectedItemChanged: (value) {
                                BlocProvider.of<EmomBloc>(context).add(EmomUpdate(forScrollWheelIndex: value));
                              },
                              children: List.generate(30, (index) =>
                                  RotatedBox(
                                      quarterTurns: 1,
                                      child: EmomForScrollWheelText(minutes: index))),
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
        if(state.status == EmomStatus.selectingWorkout){
          int forIndex = BlocProvider.of<EmomBloc>(context).state.forScrollWheelIndex!;
          print('forIndex : $forIndex');
          return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.12,
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
                              controller: FixedExtentScrollController(initialItem: forIndex),
                              physics: FixedExtentScrollPhysics(),
                              //diameterRatio: 2,
                              onSelectedItemChanged: (value) {
                                BlocProvider.of<EmomBloc>(context).add(EmomUpdate(forScrollWheelIndex: value));
                              },
                              children: List.generate(30, (index) =>
                                  RotatedBox(
                                      quarterTurns: 1,
                                      child: EmomForScrollWheelText(minutes: index))),
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




          // int forIndex = BlocProvider.of<EmomBloc>(context).state.forScrollWheelIndex!;
          // print('forIndex : $forIndex');
          // return Container(
          //     height: MediaQuery
          //         .of(context)
          //         .size
          //         .width * 0.12,
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Stack(
          //             alignment: Alignment.center,
          //             children: [
          //
          //               /// Guard Lines around Scroll Wheel
          //               Container(
          //                 height: 35,
          //
          //                 /// Test Width for Amrap Notes and Scroll Wheel
          //                 width: MediaQuery
          //                     .of(context)
          //                     .size
          //                     .width * 0.2,
          //                 decoration: BoxDecoration(
          //                     border: Border(
          //                         bottom: BorderSide(
          //                             color: Colors.blue
          //                         )
          //                     )
          //                 ),
          //               ),
          //               Stack(
          //                 alignment: Alignment.center,
          //                 children: [
          //                   Text(forIndex.toString(), style: TextStyle(fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),),
          //                   Container(
          //                     color: Colors.black,
          //                     width: MediaQuery
          //                         .of(context)
          //                         .size
          //                         .width * 0.4,
          //                     child: RotatedBox(
          //                       quarterTurns: -1,
          //                       child: ListWheelScrollView(
          //                         itemExtent: 150,
          //                         diameterRatio: 10,
          //                         /// Test Controller
          //                         /// ToDo : Created a state managed or updatable Fixed Extent Controller
          //
          //                         controller: FixedExtentScrollController(initialItem: forIndex),
          //                         physics: FixedExtentScrollPhysics(),
          //                         //diameterRatio: 2,
          //                         onSelectedItemChanged: (value) {
          //                           BlocProvider.of<EmomBloc>(context).add(EmomUpdate(forScrollWheelIndex: value));
          //                         },
          //                         children: List.generate(30, (index) =>
          //                             RotatedBox(
          //                                 quarterTurns: 1,
          //                                 child: EmomForScrollWheelText(minutes: index))),
          //                         // childDelegate: ListWheelChildBuilderDelegate(
          //                         //     childCount: 60,
          //                         //     builder: (context, index) {
          //                         //       /// ToDo : create a
          //                         //       return ScrollWheelMinutes(
          //                         //         minutes: index + 1,
          //                         //       );
          //                         //     }
          //                         // )
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               )
          //             ],
          //           ),
          //         ]
          //     )
          // );
        }


        if(state.status == EmomStatus.helper){
          /// Test
          int forIndex = BlocProvider.of<EmomBloc>(context).state.forScrollWheelIndex!;
          print('forIndex : $forIndex');
          return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.12,
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
                              controller: FixedExtentScrollController(initialItem: forIndex),
                              physics: FixedExtentScrollPhysics(),
                              //diameterRatio: 2,
                              onSelectedItemChanged: (value) {
                                BlocProvider.of<EmomBloc>(context).add(EmomUpdate(forScrollWheelIndex: value));
                              },
                              children: List.generate(30, (index) =>
                                  RotatedBox(
                                      quarterTurns: 1,
                                      child: EmomForScrollWheelText(minutes: index))),
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



          /// Original
          // int forIndex = BlocProvider.of<EmomBloc>(context).state.forScrollWheelIndex!;
          // print('forIndex : $forIndex');
          // return Container(
          //     height: MediaQuery
          //         .of(context)
          //         .size
          //         .width * 0.12,
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Stack(
          //             alignment: Alignment.center,
          //             children: [
          //
          //               /// Guard Lines around Scroll Wheel
          //               Container(
          //                 height: 35,
          //
          //                 /// Test Width for Amrap Notes and Scroll Wheel
          //                 width: MediaQuery
          //                     .of(context)
          //                     .size
          //                     .width * 0.2,
          //                 decoration: BoxDecoration(
          //                     border: Border(
          //                         bottom: BorderSide(
          //                             color: Colors.blue
          //                         )
          //                     )
          //                 ),
          //               ),
          //               Stack(
          //                 alignment: Alignment.center,
          //                 children: [
          //                   Container(
          //                     color: Colors.pink.shade200,
          //                     width: MediaQuery
          //                         .of(context)
          //                         .size
          //                         .width * 0.4,
          //                     child: RotatedBox(
          //                       quarterTurns: -1,
          //                       child: ListWheelScrollView(
          //                         itemExtent: 150,
          //                         diameterRatio: 10,
          //                         /// Test Controller
          //                         /// ToDo : Created a state managed or updatable Fixed Extent Controller
          //
          //                         controller: FixedExtentScrollController(initialItem: forIndex),
          //                         physics: FixedExtentScrollPhysics(),
          //                         //diameterRatio: 2,
          //                         onSelectedItemChanged: (value) {
          //                           BlocProvider.of<EmomBloc>(context).add(EmomUpdate(forScrollWheelIndex: value));
          //                         },
          //                         children: List.generate(30, (index) =>
          //                             RotatedBox(
          //                                 quarterTurns: 1,
          //                                 child: EmomForScrollWheelText(minutes: index))),
          //                         // childDelegate: ListWheelChildBuilderDelegate(
          //                         //     childCount: 60,
          //                         //     builder: (context, index) {
          //                         //       /// ToDo : create a
          //                         //       return ScrollWheelMinutes(
          //                         //         minutes: index + 1,
          //                         //       );
          //                         //     }
          //                         // )
          //                       ),
          //                     ),
          //                   ),
          //
          //                 ],
          //               )
          //             ],
          //           ),
          //         ]
          //     )
          // );
        }
        return Placeholder(
          fallbackHeight: 200,
          fallbackWidth: 300,
          color: Colors.pink.shade200,
        );
      });
  }
}
