

import 'package:WorkoutClock/bloc/clock_bloc/clock_bloc.dart';
import 'package:WorkoutClock/bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'package:flutter/material.dart';

import 'scroll_wheel_minutes.dart';
import 'scroll_wheel_seconds.dart';

class ScrollWheel extends StatelessWidget {
  ScrollWheel({super.key});
  

  static int breakMinuets = 1;
  static int breakSeconds = 30;


  @override
  Widget build(BuildContext context) {
    final int userSelectedMinutes = ScrollWheelBloc.breakminutes;
    final int userSelectedSeconds = ScrollWheelBloc.breakseconds;
    return Container(
      height: 150,
      //width: 300,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            child: ListWheelScrollView.useDelegate(
                itemExtent: 40,
                controller: FixedExtentScrollController(initialItem: userSelectedMinutes),
                physics: FixedExtentScrollPhysics(),
                diameterRatio: 1.5,
                onSelectedItemChanged: (value){
                  breakMinuets = value;
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 11,
                  builder: (context, index){
                    return ScrollWheelMinutes(
                      minutes: index,
                    );
                  }
                )
            ),
          ),
          Container(
            width: 50,
            child: ListWheelScrollView.useDelegate(
                itemExtent: 40,
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 1,
                    builder: (context, index){
                      return const Text('min',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white
                        )
                      );
                    }
                )
            ),
          ),
          Container(
            width: 50,
            child: ListWheelScrollView.useDelegate(
                itemExtent: 40,
                controller: FixedExtentScrollController(initialItem: userSelectedSeconds),
                physics: FixedExtentScrollPhysics(),
                diameterRatio: 1.5,
                onSelectedItemChanged: (value){
                  breakSeconds = value;
                  //Provider<>
                },
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 60,
                    builder: (context, index){
                      return ScrollWheelSeconds(
                        seconds: index,
                      );
                    }
                )
            ),
          ),
          Container(
            width: 100,
            child: ListWheelScrollView.useDelegate(
                itemExtent: 40,
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 1,
                    builder: (context, index){
                      return const Text('seconds',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white
                          )
                      );
                    }
                )
            ),
          ),
        ],
      ),
    );
  }
}
