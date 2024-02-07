
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import '../../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import '../../bloc/middle_area_bloc/middle_area_bloc.dart';
import 'Emom_text/Emom_setup_text.dart';

class EmomSelectingWorkout extends StatefulWidget {
  const EmomSelectingWorkout({super.key});

  @override
  State<EmomSelectingWorkout> createState() => _EmomSelectingWorkoutState();
}

class _EmomSelectingWorkoutState extends State<EmomSelectingWorkout> {
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
                      icon: FaIcon(
                        FontAwesomeIcons.x, size: 20, color: Colors.red,),
                      onPressed: () {

                        /// Alert Dialog
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Center(
                              child: Text('Finish EMOM Workout?', style: GoogleFonts.bebasNeue(
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

                                  /// Reset Emom Bloc Back to original State
                                  BlocProvider.of<EmomBloc>(context).add(EmomReset());
                                  BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.initial));
                                  BlocProvider.of<MiddleAreaBloc>(context).add(ResetMiddleArea(status: MiddleAreaStatus.Invisible,));
                                  Navigator.pop(context, 'OK');

                                },
                                child: Text('OK', style: GoogleFonts.bebasNeue(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.37,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.blueAccent,
                            style: BorderStyle.solid
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                            Radius.circular(25))
                    ),
                  ),
                  //const ClockTimeDisplay(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.72,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.blueAccent,
                            style: BorderStyle.solid
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                            Radius.circular(25))
                    ),
                  ),
                  /// Text Inside Amrap
                  /// Create EmomInitialText
                  EmomInitialText(),
                  /// Test
                  /// EmomInitialText(state: state);
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
