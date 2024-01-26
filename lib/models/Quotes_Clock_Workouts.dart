import 'package:WorkoutClock/bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../KeepAlive/keep_alive.dart';
import '../screens/Workout_Modes/select_workout_mode.dart';
import '../screens/workout_modes.dart';
import 'clock_display.dart';
import 'motivational_quotes.dart';


class QuotesClockWorkouts extends StatefulWidget {
  const QuotesClockWorkouts({super.key});

  @override
  State<QuotesClockWorkouts> createState() => _QuotesClockWorkoutsState();
}

PageController controller = PageController(initialPage: 1);
int _currentPosition = 1 ; /// We want to start at position 2
List<Widget> _quotesClockApp = [ KeepAlivePage(child: MotivationalQuotes()), KeepAlivePage(child: ClockDisplay()), KeepAlivePage(child: SelectWorkoutMode())];

class _QuotesClockWorkoutsState extends State<QuotesClockWorkouts> {
  @override
  Widget build(BuildContext context) {

    /// Use a page view widget to of quotes, Clock & Workout Options ( EMOM, TABATS, AMRAP )
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            allowImplicitScrolling: true,
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (num){
              if(num != 1){
                BlocProvider.of<ScrollWheelBloc>(context).add(VanishScrollWheel());
              }else{
                BlocProvider.of<ScrollWheelBloc>(context).add(CloseScrollWheel(breakMinutes: ScrollWheelBloc.breakminutes, breakSeconds: ScrollWheelBloc.breakseconds));
              }
              setState(() {
                _currentPosition = num;
              });
            },
            children: _quotesClockApp,
          ),
        Positioned(
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPosition == 0 ? Colors.blueAccent : Colors.white54
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPosition == 1 ? Colors.blueAccent : Colors.white54
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPosition == 2 ? Colors.blueAccent : Colors.white54
                ),
              ),
            ],
          ),
        )],
      ),
    );




    /// Below is Horizontal Custom Scroll View
    /*
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: const CustomScrollView(
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverToBoxAdapter(
                    child: MotivationalQuotes()
                ),
                SliverToBoxAdapter(
                    child: ClockDisplay()
                )
              ],
            ),
          ),
        Positioned(
          bottom: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange
                ),
              ),
            ],
          ),
        )
      ],
    )]
    );

     */
  }
}
