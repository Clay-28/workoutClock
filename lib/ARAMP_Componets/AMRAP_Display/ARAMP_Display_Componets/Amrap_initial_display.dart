import 'package:WorkoutClock/ARAMP_Componets/AMRAP_model.dart';
import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:WorkoutClock/bloc/note_bloc/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../../../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import '../../../workout_notes/workout_notes.dart';
import '../../ARAMP_Scroll_Wheel/Amrap_scroll_wheel_widget.dart';
import 'Amrap_Initial_Text/Amrap_builder_inner_text.dart';


class Amrap_initial_display extends StatelessWidget {
  Amrap_initial_display({super.key, required this.state});
  AMRAPState state;
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
                        /// Before Adding Alert Dialog
                        // state.copyWith(status: AMRAP_Status.initial);
                        // BlocProvider.of<AMRAPBloc>(context).state.copyWith(rounds: 0);
                        // BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.initial));
                        // /// Removes the Middle Area Amrap Horizontal Scroll View
                        // BlocProvider.of<MiddleAreaBloc>(context).add(UpdateState(status: MiddleAreaStatus.Invisable));

                        /// Alert Dialog
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Center(
                              child: Text('Finish AMRAP Workout?', style: GoogleFonts.bebasNeue(
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

                                  BlocProvider.of<AMRAPBloc>(context).add(AmrapClose());
                                  /// Remove ?
                                  //state.copyWith(status: AMRAP_Status.initial);
                                  BlocProvider.of<AMRAPBloc>(context).state.copyWith(rounds: 0);
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
                            color: Colors.green,
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
                            color: Colors.green,
                            style: BorderStyle.solid
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                            Radius.circular(25))
                    ),
                  ),
                  /// Text Inside Amrap
                  AmrapInitalText(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
