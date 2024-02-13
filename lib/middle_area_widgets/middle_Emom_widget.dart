import 'package:WorkoutClock/EMOM/Emom_Model/Emom_Model_and_Emom_Workouts.dart';
import 'package:WorkoutClock/EMOM/Emom_Widget/Emom_Workout_Card.dart';
import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


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
      if(state.status == EmomStatus.paused || state.status == EmomStatus.inProgress || state.status == EmomStatus.finished){
        /// Middles Area Widget of Emom's Notes and Alert Dialog
        /// Function that splits the AmrapModel description and removes the ","
        // String AmrapDescription(AmrapModel amrapModel) {
        //   List<String> description = widget.amrapModel.description!.split(',');
        //   String updatedDescription = '';
        //   for (String text in description) {
        //     updatedDescription += text;
        //   }
        //   return updatedDescription;
        // }

        TextEditingController controller =  TextEditingController(text: BlocProvider.of<EmomBloc>(context).emomWorkoutList.last.description ?? 'Custom Amrap');

        return GestureDetector(
          onTap: (){

            /// On Tap Display that "Add Notes Bottom Sheet Widget"
            /*
              showBottomSheet(
                  enableDrag: false,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  context: context,
                  builder: (context){
                    return Workout_Notes_Bottom_Sheet(controller: BlocProvider.of<NoteBloc>(context).state.controller);
                  }

              );

               */

            /// Goal, Try and Make the Middle Area Amrap Description Text Customizable
            /// Alert Dialog is a text field of the last Amrap Model
            showDialog(context: context, builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.all(0),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2,
                    )),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                            maxLines: 500,
                            decoration: const InputDecoration(
                                border: InputBorder.none
                            ),
                            controller: controller,
                            style: GoogleFonts.bebasNeue(
                                fontSize: 25,
                                color: Colors.white,
                                textStyle: TextStyle(
                                  height: 1.25,
                                  overflow: TextOverflow.visible,
                                )
                            )
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        //BlocProvider.of<AMRAPBloc>(context).add(UpdateAmrapDescription(description: controller.text));
                        /// Create an event that updates the state and last emomModel description to the Controller

                        /// Options
                        /// -> Update the state.emomModel Description
                        /// -> Update emomWorkoutList.last.description

                        BlocProvider.of<EmomBloc>(context).emomWorkoutList.last.description = controller.text;
                        Navigator.of(context).pop();

                        /// How many Amrap Classes are in AmrapList
                        //print('Amrap List Count: ${AMRAPBloc.AmrapsList.length}');
                      },
                      child: Text( 'Update Notes',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 25,
                          color: Colors.white,
                          textStyle: TextStyle(
                            height: 1.25,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            );
          },
          child: Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.9,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text( state.emomModel?.description ?? '',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 45,
                          color: Colors.white,
                          textStyle: TextStyle(
                            height: 1.25,
                            overflow: TextOverflow.visible,
                          )
                      )
                  ),
                )
              ],
            ),
          ),
        );
      }
      return Placeholder(color: Colors.pink,);
    });
  }
}
