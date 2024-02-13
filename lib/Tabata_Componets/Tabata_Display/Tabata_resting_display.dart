import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import '../../bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import '../../bloc/middle_area_bloc/middle_area_bloc.dart';
import 'Tabata_clock_text.dart';
import 'Tabata_rounds_display.dart';

class TabataRestingDisplay extends StatelessWidget {
  TabataRestingDisplay({super.key, required this.state});

  TabataState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.x, size: 20, color: Colors.red,),
                        onPressed: () {

                          /// Before Alert Dialog
                          // BlocProvider.of<AMRAPBloc>(context).add(AmrapClose());
                          // BlocProvider.of<WorkoutModesBloc>(context)
                          //     .add(SelectWorkout(
                          //     status: WorkoutStatus.initial));

                          /// Alert Dialog
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Center(
                                  child: Text('Finish TABATA Workout?', style: GoogleFonts.bebasNeue(
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                content: Text('Notes will not be deleted if you decide to finish workout',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                    child: Text('Cancel', style: GoogleFonts.bebasNeue(
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {

                                      // BlocProvider.of<AMRAPBloc>(context).add(AmrapClose());
                                      // /// Removes the Middle Area Amrap Horizontal Scroll View
                                      // BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Invisible, widgetIndex: -1));
                                      // /// Removes the Middle Area Amrap Horizontal Scroll View
                                      // BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.initial));
                                      // Navigator.pop(context, 'OK');

                                      /// Resets Emom Bloc
                                      BlocProvider.of<TabataBloc>(context).add(TabataReset(fullReset: false));
                                      /// Removes the Middle Area Amrap Horizontal Scroll View
                                      BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Invisible, widgetIndex: -1));
                                      /// Removes the Middle Area Amrap Horizontal Scroll View
                                      BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.initial));
                                      Navigator.pop(context, 'OK');

                                    },
                                    child: Text('OK', style: GoogleFonts.bebasNeue(
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                    ),
                                  ),
                                ],
                              ));
                        }
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TweenAnimationBuilder(
                    // ToDo: Remove ~10
                      tween: Tween(begin: 1, end: state.restInterval / (state.tabataModel.restInterval)),
                      duration: const Duration(seconds: 1),
                      builder: (context, value, child) {
                        return Container(
                          width: 200,
                          height: 200,
                          child: CircularCappedProgressIndicator(
                            backgroundColor: Colors.white54,
                            color: Colors.blueAccent,
                            strokeWidth: 5.0,
                            strokeCap: StrokeCap.round,
                            value: value + 0 ,
                            /// Value = Time / Interval
                          ),
                        );
                      }
                  ),
                  TabataClockText(),
                  Positioned(
                    top: 50,
                    child: Text('Rest', style: GoogleFonts.bebasNeue(
                      fontSize: 30,
                      color: Colors.white,
                    ),),
                  ),
                  Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2,
                            color: Colors.blueAccent,
                            style: BorderStyle.solid)),
                  )
                ],
              ),
            ),

          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            TabataRoundsDisplay(),
            TabataTotalDurationClockText(),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Stack(
                    alignment: Alignment.center,
                    children:[
                      Container(
                        width: 87,
                        height: 87,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.white54, style: BorderStyle.solid)
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white54,
                          fixedSize: const Size(75, 75),
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {

                          BlocProvider.of<TabataBloc>(context).add(TabataPause());

                        },
                        child: FaIcon(
                          FontAwesomeIcons.pause,
                          size: 25,
                          color: Colors.white,
                        )
                      )
                    ]),
              ),
            )
          ],
        )
      ],
    );
  }
}
