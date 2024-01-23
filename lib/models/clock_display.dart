import 'package:flutter/material.dart';

import '../scroll_wheel/break_time_ui.dart';
import '../workout_clock_componet/action_buttons_widget.dart';
import '../workout_clock_componet/clock_ring_widget.dart';

class ClockDisplay extends StatelessWidget {
  const ClockDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ClockRing(),
              //TimerText(color: Colors.white54,),
            ],
          ),
          ClockActions(),
        ],
      ),
    );
  }
}
