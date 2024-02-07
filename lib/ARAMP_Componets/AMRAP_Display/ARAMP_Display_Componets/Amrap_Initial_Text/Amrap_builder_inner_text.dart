import 'package:WorkoutClock/ARAMP_Componets/AMRAP_Display/ARAMP_Display_Componets/Amrap_Initial_Text/Amrap_selecting_workout_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../../../../bloc/middle_area_bloc/middle_area_bloc.dart';
import '../../../../bloc/note_bloc/note_bloc.dart';
import '../../../AMRAP_model.dart';
import '../../../ARAMP_Scroll_Wheel/Amrap_scroll_wheel_widget.dart';
import 'Amrap_helper_text.dart';


class AmrapInitalText extends StatelessWidget {
  AmrapInitalText({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AMRAPBloc,AMRAPState>
      (builder: (context,state){
        /// Initial Text
        if(state.status == AMRAP_Status.initial){
          AmrapModel amrapModel = BlocProvider.of<AMRAPBloc>(context).state.amrapModel!;
          return Container(
            //color: Colors.white54,
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
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: AmrapScrollWheel(amrapModel: amrapModel),
                  ),
                ),
                /// Start Text Button
                TextButton(
                  onPressed: () async {
                    /// Collects the Scroll Wheel Value and Sets the State Duration
                    int duration = AmrapScrollWheel.duration;
                    //int duration = state.duration;
                    /// Adds a Amrap Deatials to notes
                    AmrapModel newAmrapWorkout = AmrapModel(duration: duration * 60, rounds: 0, description: '$duration Minutes\nCustom AMRAP');
                    BlocProvider.of<AMRAPBloc>(context).add(CreateAmrapModel(duration: duration * 60, rounds: 0));
                    BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: duration, status: AMRAP_Status.paused, amrapModel: newAmrapWorkout));
                    BlocProvider.of<NoteBloc>(context).add(AddWorkout(ArmapWorkout: newAmrapWorkout));


                    /// Removes the Amrap Horizontal Scroll View
                   /// BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Invisible));
                  },
                  child: Text('Start', style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    color: Colors.white,
                  )),)
              ],
            ),
          );
        }
        if(state.status == AMRAP_Status.selectingWorkout){
          AmrapModel amrapModel = BlocProvider.of<AMRAPBloc>(context).state.amrapModel!;
          print('\n\nSelecting Workout amrapModel : ${amrapModel.description} \nDuration ${amrapModel.duration}');
          // Make a Static Variable in Amrap Bloc
          // Horizontal Scroll when tapped updates the
          return Amrap_Selecting_Workout_Text(amrapModel: amrapModel);
        }
        if(state.status == AMRAP_Status.helper){
          AmrapModel amrapModel = BlocProvider.of<AMRAPBloc>(context).state.amrapModel!;
          print('\n\nSelecting Workout amrapModel : ${amrapModel.description} \nDuration ${amrapModel.duration}');
          // Make a Static Variable in Amrap Bloc
          // Horizontal Scroll when tapped updates the
          return Amrap_Helper_Workout_Text(amrapModel: amrapModel);
        }
        /// If Error, State, or Amrap Status Doesn't Exsits
        return Center(child: (Icon(Icons.error_outline, size: 50,)));
    });
  }
}
