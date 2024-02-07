
import 'package:WorkoutClock/ARAMP_Componets/AMRAP_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import 'Amrap_Scroll_Wheel_Minutes.dart';


class AmrapScrollWheel extends StatelessWidget {
  AmrapScrollWheel({super.key, required this.amrapModel});


  AmrapModel amrapModel;
  static int duration = 10;

  @override
  Widget build(BuildContext context) {

    FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: amrapModel.duration -1);
    ///final int userSelectedMinutes = ScrollWheelBloc.breakminutes;
    return BlocBuilder<AMRAPBloc, AMRAPState>
      (
        builder: (context, state,){
        if(state.status == AMRAP_Status.initial) {
          return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.30,
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
                              border: Border.symmetric(
                                vertical: BorderSide(
                                    color: Colors.green
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          child: ListWheelScrollView.useDelegate(
                              itemExtent: 44,
                              controller: scrollController,
                              physics: FixedExtentScrollPhysics(),
                              diameterRatio: 2,
                              onSelectedItemChanged: (value) {
                                duration = value + 1;
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 60,
                                  builder: (context, index) {
                                    return AmrapScrollWheelText(minutes: index + 1);
                                  }
                              )
                          ),
                        ),
                      ],
                    ),
                  ]
              )
          );
        }

        if(state.status == AMRAP_Status.selectingWorkout){
          return Container(
              height: MediaQuery.of(context).size.width * 0.30,
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
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(
                                    color: Colors.green
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: ListWheelScrollView.useDelegate(
                              itemExtent: 44,
                              //controller: FixedExtentScrollController(initialItem: amrapModel.duration),
                              controller: scrollController,
                              physics: FixedExtentScrollPhysics(),
                              diameterRatio: 2,
                              onSelectedItemChanged: (value){
                                //duration = value + 1;
                                duration = value + 1;
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 60,
                                  builder: (context, index){
                                    return AmrapScrollWheelText(
                                      minutes: index + 1 ,
                                    );
                                  }
                              )
                          ),
                        ),
                      ],
                    ),
                  ]
              )
          );
        }

        if(state.status == AMRAP_Status.helper){
          //int scrollWheelIndex = amrapModel.duration -1;
          //print('\nAmrap Scroll Wheel selecting Workout -> $scrollWheelIndex');
          print(' Yeee Haw Amrap Scroll Wheel selecting Workout static duration: $duration \n'
              'Scroll Controller initial Item${scrollController.initialItem}');
          return Container(
              height: MediaQuery.of(context).size.width * 0.30,
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
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(
                                    color: Colors.green
                                ),
                              )
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: ListWheelScrollView.useDelegate(
                              itemExtent: 44,
                              //controller: FixedExtentScrollController(initialItem: amrapModel.duration),
                              controller: scrollController,
                              physics: FixedExtentScrollPhysics(),
                              diameterRatio: 2,
                              onSelectedItemChanged: (value){
                                duration = value + 1;
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 60,
                                  builder: (context, index){
                                    return AmrapScrollWheelText(
                                      minutes: index + 1 ,
                                    );
                                  }
                              )
                          ),
                        ),
                      ],
                    ),
                  ]
              )
          );
        }
        return Text('Error');
    });
  }
}
