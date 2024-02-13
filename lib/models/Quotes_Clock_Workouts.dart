import 'dart:math';

import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:WorkoutClock/bloc/Quotes_Clock_Workouts_Bloc/QuotesClockWorkoutBloc.dart';
import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:WorkoutClock/bloc/note_bloc/note_bloc.dart';
import 'package:WorkoutClock/bloc/scroll_wheel_bloc/scroll_wheel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../KeepAlive/keep_alive.dart';
import '../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import '../bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import '../screens/Workout_Modes/select_workout_mode.dart';
import '../screens/workout_modes.dart';
import 'clock_display.dart';
import 'motivational_quotes.dart';


class QuotesClockWorkouts extends StatefulWidget {
  const QuotesClockWorkouts({super.key});


  void setCurrentPosition({required int index}){
    _currentPosition = index;
    print("QuotesClockWorkout: index: $index");
  }


  @override
  State<QuotesClockWorkouts> createState() => _QuotesClockWorkoutsState();
}


PageController controller = PageController(initialPage: 1);
int _currentPosition = 1 ; /// We want to start at position 2
bool locked = false;

List<Widget> _quotesClockApp = [ KeepAlivePage(child: MotivationalQuotes()), KeepAlivePage(child: ClockDisplay()), KeepAlivePage(child: SelectWorkoutMode())];


class _QuotesClockWorkoutsState extends State<QuotesClockWorkouts> {



  /// Get a value form note bloc provider
  /// -> if bool == lock
  /// setState () physics : NoneScrollable

  @override
  Widget build(BuildContext context) {

    /// Use a page view widget to of quotes, Clock & Workout Options ( EMOM, TABATS, AMRAP )
    return BlocBuilder<QCWBloc,QCWState>
      (builder: (context,state){
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                //color: Colors.green
              )
          ),
          height: MediaQuery
              .of(context)
              .size
              .height * 0.45,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                allowImplicitScrolling: true,
                //physics: locked ? NeverScrollableScrollPhysics() : null,
                physics: state.locked ? NeverScrollableScrollPhysics() : null,
                scrollDirection: Axis.horizontal,
                controller: controller,
                onPageChanged: (num) {
                  setState(() {
                    _currentPosition = num;
                  });
                  if (num != 1) {

                    /// Middle Area Bloc updates MiddleAreaWidget with nothing
                    BlocProvider.of<MiddleAreaBloc>(context).add(
                        MiddleAreaUpdateState(status: MiddleAreaStatus.Invisible));

                  }
                  if (num == 1) {
                    BlocProvider.of<MiddleAreaBloc>(context).add(
                        MiddleAreaUpdateState(status: MiddleAreaStatus.Clock));

                    BlocProvider.of<NoteBloc>(context).add(HideNotes(noteStatus: NoteStatus.open));
                    print('Middle area status :${WorkoutModesBloc.status}');

                  }
                  if (num == 2) {

                    TabataStatus tabataStatus = BlocProvider.of<TabataBloc>(context).state.status;

                    /// This condition displays the state.amrapModel's description in the Middle Area
                    /// if AMRAMBloc state is either paused or inProgressed
                    if(AMRAPBloc.Amrap_status == AMRAP_Status.paused || AMRAPBloc.Amrap_status == AMRAP_Status.inProgress){
                      BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Amramp));
                    }

                    /// This condition controlls the Amrap Workout Scroll View display, by updating the Amrap Status
                    /// When moving from one page view to another
                    if (WorkoutModesBloc.status == WorkoutStatus.ARAMP &&
                        (AMRAPBloc.Amrap_status == AMRAP_Status.initial || AMRAPBloc.Amrap_status == AMRAP_Status.selectingWorkout)) {
                      BlocProvider.of<MiddleAreaBloc>(context).add(
                          MiddleAreaUpdateState(status: MiddleAreaStatus.Amramp));
                    }

                    if (WorkoutModesBloc.status == WorkoutStatus.EMOM &&
                        (EmomBloc().state.status == EmomStatus.setup || EmomBloc().state.status == EmomStatus.selectingWorkout)) {
                      BlocProvider.of<MiddleAreaBloc>(context).add(
                          MiddleAreaUpdateState(status: MiddleAreaStatus.Emom));
                    }

                    // if((TabataBloc().state.status == TabataStatus.inProgress || TabataBloc().state.status == TabataStatus.paused || TabataBloc().state.status == TabataStatus.resting)){
                    //  print('How me the money');
                    //   BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Tabata));
                    // }
                    if(WorkoutModesBloc.status == WorkoutStatus.TABATA && (tabataStatus == TabataStatus.paused || tabataStatus == TabataStatus.resting || tabataStatus == TabataStatus.inProgress)){

                      print('fatbot and little man');
                      BlocProvider.of<MiddleAreaBloc>(context).add(
                          MiddleAreaUpdateState(status: MiddleAreaStatus.Tabata));
                    }


                    print('Middle area status :${WorkoutModesBloc.status}');

                    /// Hide Add Notes
                    BlocProvider.of<NoteBloc>(context).add(HideNotes(noteStatus: NoteStatus.hidden));


                  }
                },
                children: _quotesClockApp,
              ),
              Positioned(
                  bottom: 40,
                  child: Container(
                    width: 150,
                    child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPosition == 0 ? Colors.blueAccent : Colors
                                        .white54
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPosition == 1 ? Colors.blueAccent : Colors
                                        .white54
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPosition == 2 ? Colors.blueAccent : Colors
                                        .white54
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                  )
              ),
            ],
          ),
        );
    });

  }
}
