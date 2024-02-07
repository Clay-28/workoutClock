import 'package:WorkoutClock/EMOM/Emom_Model/Emom_Model_and_Emom_Workouts.dart';
import 'package:WorkoutClock/EMOM/Emom_Widget/Emom_Workout_Card.dart';
import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmomMiddleAreaBuilder extends StatelessWidget {
  const EmomMiddleAreaBuilder({super.key});


  @override
  Widget build(BuildContext context) {


    int emomWorkoutIndex = BlocProvider.of<MiddleAreaBloc>(context).state.emomWorkoutIndex!;
    print('emomWorkoutIndex : ${emomWorkoutIndex}');

    List<EmomModel> emomWorkouts = EmomWorkouts().fetchPopularEmomWorkouts();
    return BlocBuilder<EmomBloc, EmomState>
      (builder: (context, state) {
      if (state.status == EmomStatus.setup) {
        return Container(
          height: 220,
          decoration: BoxDecoration(
              border: Border.all(
                //color: Colors.white
              )
          ),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  Container(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
              itemCount: 10, //amrapWorkouts.length-1,
              itemBuilder: (context, index) {
                /// _test Border Color Value should come from
                return EmomWorkoutCard(index: index, emomModel: emomWorkouts[index], testBorderColor: index == emomWorkoutIndex ? true : false);
              }
          ),
        );
      }
      if(state.status == EmomStatus.selectingWorkout){
        // return Container(
        //   height: 220,
        //   decoration: BoxDecoration(
        //       border: Border.all(
        //         //color: Colors.white
        //       )
        //   ),
        //   child: ListView.separated(
        //       scrollDirection: Axis.horizontal,
        //       separatorBuilder: (context, index) =>
        //           Container(width: MediaQuery
        //               .of(context)
        //               .size
        //               .width * 0.05),
        //       itemCount: 10, //amrapWorkouts.length-1,
        //       itemBuilder: (context, index) {
        //         /// _test Border Color Value should come from
        //         return EmomWorkoutCard(index: index, emomModel: emomWorkouts[index], testBorderColor: index == emomWorkoutIndex ? true : false);
        //       }
        //   ),
        // );
        return Container(
          height: 220,
          decoration: BoxDecoration(
              border: Border.all(
                //color: Colors.white
              )
          ),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  Container(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
              itemCount: 10, //amrapWorkouts.length-1,
              itemBuilder: (context, index) {
                /// _test Border Color Value should come from
                return EmomWorkoutCard(index: index, emomModel: emomWorkouts[index], testBorderColor: index == emomWorkoutIndex ? true : false);
              }
          ),
        );
      }
      if(state.status == EmomStatus.helper){
        return Container(
          height: 220,
          decoration: BoxDecoration(
              border: Border.all(
                //color: Colors.white
              )
          ),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  Container(width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
              itemCount: 10, //amrapWorkouts.length-1,
              itemBuilder: (context, index) {
                /// _test Border Color Value should come from
                return EmomWorkoutCard(index: index, emomModel: emomWorkouts[index], testBorderColor: index == emomWorkoutIndex ? true : false);
              }
          ),
        );
      }
      return Placeholder(color: Colors.pink,);
    });
  }
}
