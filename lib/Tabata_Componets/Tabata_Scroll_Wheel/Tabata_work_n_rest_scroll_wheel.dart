import 'dart:math';

import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../EMOM/Emom_Scroll_Wheel/Emom_For_Scroll_Wheel_Text.dart';
import 'Tabata_work_and_rest_Scroll_Wheel_text.dart';

class TabataWorkRestScrollWheel extends StatefulWidget {
  TabataWorkRestScrollWheel ({super.key, required this.totalItems, required this.scrollController, required this.restInterval});

  /// Rather than using a helper a function
  /// Lets try a Statfull widget and call @override init state

  /// Update values from state w/ BP


  /// Bool is used to determine either state.Interval or state.restInterval to update.
  bool restInterval;
  int totalItems;
  FixedExtentScrollController scrollController;

  @override
  State<TabataWorkRestScrollWheel> createState() => _TabataWorkRestScrollWheelState();
}

class _TabataWorkRestScrollWheelState extends State<TabataWorkRestScrollWheel> {

  @override
  initState() {
    widget.scrollController;
  }

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
                                controller: widget.scrollController,
                                physics: FixedExtentScrollPhysics(),
                                //diameterRatio: 2,
                                onSelectedItemChanged: (value) {
                                  if(widget.restInterval == true){
                                    BlocProvider.of<TabataBloc>(context).add(UpdateTabata(restControllerIndex: value + 1));
                                  }else{
                                    BlocProvider.of<TabataBloc>(context).add(UpdateTabata(intervalControllerIndex: value + 1));
                                  }
                                },
                                children: List.generate(widget.totalItems, (index) =>
                                    RotatedBox(
                                        quarterTurns: 1,
                                        child: TabataWorkRestScrollText(index: index,))),
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
                                //controller: widget.scrollController,
                                controller: state.restController,
                                physics: FixedExtentScrollPhysics(),
                                //diameterRatio: 2,
                                onSelectedItemChanged: (value) {
                                  if(widget.restInterval == true){
                                    BlocProvider.of<TabataBloc>(context).add(UpdateTabata(restControllerIndex: value + 1));
                                  }else{
                                    BlocProvider.of<TabataBloc>(context).add(UpdateTabata(intervalControllerIndex: value + 1));
                                  }
                                },
                                children: List.generate(widget.totalItems, (index) =>
                                    RotatedBox(
                                        quarterTurns: 1,
                                        child: TabataWorkRestScrollText(index: index,))),
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

