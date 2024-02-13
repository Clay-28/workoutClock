import 'package:WorkoutClock/ARAMP_Componets/AMRAP_model.dart';
import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:WorkoutClock/bloc/note_bloc/note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ARAMP_Componets/Amrap_card_widget.dart';
import '../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../workout_notes/workout_notes.dart';

class MiddleAmrapWidget extends StatelessWidget {
  MiddleAmrapWidget({super.key});

  /// Collect both index and border color for AmrapWorkoutCard from MiddleAreaBloc


  @override
  Widget build(BuildContext context) {

    //int widgetIndex = MiddleAreaBloc().state.widgetIndex!;
    //int widgetIndex = MiddleAreaBloc.amrapWorkoutIndex;
    int widgetIndex = BlocProvider.of<MiddleAreaBloc>(context).state.widgetIndex!;
    bool borderColor = MiddleAreaBloc.amrapBorderColor;

    //int testIndex = context.select((MiddleAreaBloc bloc) => bloc.);
    // double totalTime = context.select((MiddleAreaBloc bloc) => bloc.);

    List<AmrapModel> amrapWorkouts = AmrapWorkouts().fetchPopularAmrapWorkouts();

    return BlocBuilder<AMRAPBloc,AMRAPState>
      (
        //buildWhen: (previous, current) => current.status != AMRAP_Status.selectingWorkout,
        builder: (context,state){
        if(state.status == AMRAP_Status.initial /*|| state.status == AMRAP_Status.selectingWorkout */){
          return Container(
            height: 220,
            decoration: BoxDecoration(
              border: Border.all(
                //color: Colors.white
              )
            ),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context,index)=> Container(width: MediaQuery.of(context).size.width * 0.05),
                itemCount: amrapWorkouts.length-1,
                itemBuilder: (context, index){
                  /// _test Border Color Value should come from
                  return AmrapWorkoutCard(amrapModel: amrapWorkouts[index], index: index, testBorderColor: index == widgetIndex ? true : false);
                }
            ),
          );
        }if(state.status == AMRAP_Status.selectingWorkout || state.status == AMRAP_Status.helper){
          return Container(
            height: 220,
            decoration: BoxDecoration(
                border: Border.all(
                  //color: Colors.white
                )
            ),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context,index)=> Container(width: MediaQuery.of(context).size.width * 0.05),
                itemCount: amrapWorkouts.length-1,
                itemBuilder: (context, index){
                  /// _test Border Color Value should come from
                  //return AmrapWorkoutCard(amrapModel: amrapWorkout[1], index: index, testBorderColor: false,);
                  return AmrapWorkoutCard(amrapModel: amrapWorkouts[index], index: index, testBorderColor: index == widgetIndex ? true : false);
                }
            ),
          );
        }if(state.status == AMRAP_Status.paused || state.status == AMRAP_Status.inProgress){


          /// Function that splits the AmrapModel description and removes the ","
          // String AmrapDescription(AmrapModel amrapModel) {
          //   List<String> description = widget.amrapModel.description!.split(',');
          //   String updatedDescription = '';
          //   for (String text in description) {
          //     updatedDescription += text;
          //   }
          //   return updatedDescription;
          // }



          TextEditingController controller =  TextEditingController(text: '${state.amrapModel?.description ?? 'Custom Amrap'} ');

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
                      color: Colors.green,
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
                                fontSize: 35,
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
                          BlocProvider.of<AMRAPBloc>(context).add(UpdateAmrapDescription(description: controller.text));
                          Navigator.of(context).pop();

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
                    child: Text( state.amrapModel!.description! == null ? '' : state.amrapModel!.description!,
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
        /// Add a Container with State.amrapModel.description for both Amrap Paused and InProgress
        return Placeholder();
    });
  }
}

/*
onTap: (){
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
            },
 */