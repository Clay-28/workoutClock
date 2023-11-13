import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'scroll_wheel_minutes.dart';
import 'scroll_wheel_seconds.dart';

class ScrollWheel extends StatelessWidget {
  const ScrollWheel({super.key});

  static int breakMinuets = 0;
  static int breakSeconds = 0;
  //static ScrollController test = ScrollController();

  @override
  Widget build(BuildContext context) {
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
                physics: FixedExtentScrollPhysics(),
                diameterRatio: 1.5,
                onSelectedItemChanged: (value){
                  breakMinuets = value;
                  print('Scroll Break Min: $breakMinuets');
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
                physics: FixedExtentScrollPhysics(),
                diameterRatio: 1.5,
                onSelectedItemChanged: (value){
                  breakSeconds = value;
                  print('Scroll Break Seconds: $breakSeconds');
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
