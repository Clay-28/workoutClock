import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import 'Tabata_rounds_scroll_text.dart';

class TabataRoundScrollWheel extends StatelessWidget {
  TabataRoundScrollWheel({super.key, required this.totalItems, required this.scrollController});

  int totalItems;
  FixedExtentScrollController scrollController;

  @override
  Widget build (BuildContext context){
    return BlocBuilder<TabataBloc, TabataState>(
        builder: (context, state) {
          if (state.status == TabataStatus.setup) {
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
                                .width * 0.25,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.redAccent.shade200
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
                                controller: scrollController,
                                physics: FixedExtentScrollPhysics(),
                                //diameterRatio: 2,
                                onSelectedItemChanged: (value) {
                                  BlocProvider.of<TabataBloc>(context).add(UpdateTabata(rounds: value +1));
                                  print(value);
                                },
                                children: List.generate(totalItems, (index) =>
                                    RotatedBox(
                                        quarterTurns: 1,
                                        child: TabataRoundsScrollText(rounds: index))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                )
            );
          }if(state.status == TabataStatus.selectingWorkout){
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
                                .width * 0.25,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.redAccent.shade200
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
                                controller: scrollController,
                                physics: FixedExtentScrollPhysics(),
                                //diameterRatio: 2,
                                onSelectedItemChanged: (value) {
                                  //BlocProvider.of<EmomBloc>(context).add(EmomUpdate(forScrollWheelIndex: value));

                                },
                                children: List.generate(totalItems, (index) =>
                                    RotatedBox(
                                        quarterTurns: 1,
                                        child: TabataRoundsScrollText(rounds: index))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                )
            );
          }

          return Placeholder(
            fallbackHeight: 200,
            fallbackWidth: 300,
            color: Colors.pink.shade200,
          );
        });
  }
}
