import 'package:WorkoutClock/ARAMP_Componets/AMRAP_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../../../../bloc/middle_area_bloc/middle_area_bloc.dart';
import '../../../../bloc/note_bloc/note_bloc.dart';
import '../../../ARAMP_Scroll_Wheel/Amrap_scroll_wheel_widget.dart';

class Amrap_Selecting_Workout_Text extends StatelessWidget {
  Amrap_Selecting_Workout_Text({super.key, required this.amrapModel});
  AmrapModel? amrapModel;
  @override
  Widget build(BuildContext context) {
    return Container(
          //color: Colors.pink.shade300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('AMRAP', style: GoogleFonts.bebasNeue(
                fontSize: 30,
                color: Colors.white,)
              ),
              Text('As Many Rounds As Possible', style: GoogleFonts.bebasNeue(
                fontSize: 20,
                color: Colors.white,
              )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  //color: Colors.white54,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(

                        child: Flexible(
                          child: Text(
                            amrapModel!.description!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      AmrapScrollWheel(amrapModel: amrapModel ?? AmrapModel(duration: 0, description: '', rounds: 0 )),
                    ],
                  ),
                ),
              ),

              /// Start Text Button
              TextButton(
                onPressed: () async {
                  /// Collects the Scroll Wheel Value and Sets the State Duration
                  int duration = AmrapScrollWheel.duration;
                  print('\nSelected Scroll Wheel: $duration');
                  //int duration = state.duration;

                  /// Adds a Amrap Details to notes
                  AmrapModel newAmrapWorkout = AmrapModel(duration: duration * 60, rounds: 0, description: '${amrapModel?.description}\n\nNotes:' );
                  /// Original & Works
                  //BlocProvider.of<AMRAPBloc>(context).add(CreateAmrapModel(duration: duration * 60, rounds: 0, description: amrapModel?.description));
                  BlocProvider.of<AMRAPBloc>(context).add(CreateAmrapModel(duration: duration * 60, rounds: 0, description: '${amrapModel?.description}\n\nNotes:' ));


                  BlocProvider.of<NoteBloc>(context).add(AddWorkout(ArmapWorkout: newAmrapWorkout,));

                  /// Test
                  //BlocProvider.of<AMRAPBloc>(context).add(CreateAmrapModel(duration: duration * 60, rounds: 0, description: '${amrapModel?.description}\n\nNotes:'));
                  BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: duration, status: AMRAP_Status.paused, amrapModel: AmrapModel(duration: duration, rounds: 0, description: '${amrapModel?.description}\n\nNotes:')));



                  /// Middle Area Updates to display Amrap Model's Description
                  /// When Start is tapped


                  /// Removes the Amrap Horizontal Scroll View
                  //BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Invisible));




                },
                child: Text('Start', style: GoogleFonts.bebasNeue(
                  fontSize: 30,
                  color: Colors.white,
                )),)
            ],
          ),
        );
  }
}
