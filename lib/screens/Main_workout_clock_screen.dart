import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:WorkoutClock/models/Quotes_Clock_Workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../middle_area_widgets/main_middle_area_builder.dart';
import '../slide_to_finish/slide_action_widget.dart';
import '../workout_notes/workout_notes.dart';


class WorkoutClock extends StatelessWidget {
  const WorkoutClock({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
          canPop: false,
          /// Add a Single Child Scroll View to help RenderFlex overlapping between *Add-Notes Show-Bottom-Sheet and Scroll Wheel
          child: Padding(
            padding: EdgeInsets.fromLTRB(0,50,0,0),
            child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// CustomScrollView -> Horizonal, Quotes, Clock
                          QuotesClockWorkouts(),
                          MiddleAreaBuilder(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SlideToFinish(),
                              WorkoutNotes(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
        );
  }
}
