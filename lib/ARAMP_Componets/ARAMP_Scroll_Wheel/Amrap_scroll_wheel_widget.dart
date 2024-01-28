
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Amrap_Scroll_Wheel_Minutes.dart';


class AmrapScrollWheel extends StatelessWidget {
  AmrapScrollWheel({super.key});
  

  static int duration = 9;


  @override
  Widget build(BuildContext context) {


    ///final int userSelectedMinutes = ScrollWheelBloc.breakminutes;



    return Container(
      height: MediaQuery.of(context).size.width * 0.30,
      width: MediaQuery.of(context).size.width * 0.50,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 30,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: Colors.green
                    ),
                  )
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListWheelScrollView.useDelegate(
                    itemExtent: 40,
                    controller: FixedExtentScrollController(initialItem: duration - 1 ),
                    physics: FixedExtentScrollPhysics(),
                    diameterRatio: 2,
                    onSelectedItemChanged: (value){
                      duration = value + 1;
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 60,
                        builder: (context, index){
                          return ScrollWheelMinutes(
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
}
