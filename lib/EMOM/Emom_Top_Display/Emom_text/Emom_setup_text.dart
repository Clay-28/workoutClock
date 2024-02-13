import 'package:WorkoutClock/EMOM/Emom_Model/Emom_Model_and_Emom_Workouts.dart';
import 'package:WorkoutClock/EMOM/Emom_Scroll_Wheel/Emom_Every_Scroll_Wheel.dart';
import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Emom_Scroll_Wheel/Emom_For_Scroll_Wheel.dart';

class EmomInitialText extends StatelessWidget {
  EmomInitialText({super.key,});

  @override
  Widget build(BuildContext context) {
    /// This might not rebuild
    ///EmomState state = BlocProvider.of<EmomBloc>(context).state;

    /// Below is another option to collect data from a bloc
    //int testInterval = context.select((EmomBloc bloc) => bloc.state.interval);

    /// Emom Scroll Wheel Text
    //Map<int, List<dynamic>> scrollWheelText = EmomBloc().scrollWheelDescriptionText(totalMinutes: 30);
    /// Emom forScrollWheelIndex

    String? everyText = BlocProvider.of<EmomBloc>(context).state.everyScrollText;
    print(everyText);
    String? forText = BlocProvider.of<EmomBloc>(context).state.forScrollText;
    int interval = BlocProvider.of<EmomBloc>(context).state.interval;
    int totalDuration = BlocProvider.of<EmomBloc>(context).state.totalDuration;
    //int rounds = (totalDuration == 0 ? 600 : totalDuration   ~/  interval == 0 ? 60 : interval  );
    int rounds = totalDuration ~/ interval;

    EmomModel emomModel = BlocProvider.of<EmomBloc>(context).state.emomModel;

    EmomState emomState = BlocProvider.of<EmomBloc>(context).state;


    return Container(
      width: MediaQuery.of(context).size.width * 0.72,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Emom', style: GoogleFonts.bebasNeue(
            fontSize: 30,
            color: Colors.white)
          ),
          Text('Every $everyText', style: GoogleFonts.bebasNeue(
            fontSize: 30,
            color: Colors.white,)
          ),
          Text('For $forText, $rounds Rounds', style: GoogleFonts.bebasNeue(
            fontSize: 30,
            color: Colors.white,)
          ),
          /// Every Horizontal Scroll Wheel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Every', style: GoogleFonts.bebasNeue(
                fontSize: 30,
                color: Colors.white,)
              ),
              /// Original -> But does not automatically update States
              EmomEveryScrollWheel(),
              /// Scroll Whell
            ],
          ),
          /// For with Horizontal Scroll Wheel
          Container(
            //color: Colors.pink.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('For', style: GoogleFonts.bebasNeue(
                  fontSize: 30,
                  color: Colors.white,)
                ),
                EmomForScrollWheel(),
              ],
            ),
          ),
          TextButton(
            onPressed: (){
              /// Creates a EmomModel, Sets the Emom Display to Paused, And Hides the
              BlocProvider.of<EmomBloc>(context).add(EmomUpdate(emomStatus: EmomStatus.paused));
              /// Creates and adds an EmomModel in the state.emomWorkouts
              BlocProvider.of<EmomBloc>(context).add(CreateEmomModel());
            },
              // onPressed: interval < totalDuration ? (){
              //   /// Updates Emom state to Paused
              //
              // } : ()=> null,
            child: Text('Start', style: GoogleFonts.bebasNeue(
              fontSize: 30,
              color: Colors.white)
            ),
          )
        ],
      ),
    );
  }
}
