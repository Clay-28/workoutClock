import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Tabata_Bloc/Tabata_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TabataMiddleAreaBuilder extends StatelessWidget {
  const TabataMiddleAreaBuilder ({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController controller =  TextEditingController(text: BlocProvider.of<TabataBloc>(context).tabataWorkouts.last.description);


    return BlocBuilder<TabataBloc,TabataState>
      (builder: (context,state){

        if(state.status == TabataStatus.paused ||
            state.status == TabataStatus.inProgress ||
            state.status == TabataStatus.resting ||
            state.status == TabataStatus.finished){
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

                          BlocProvider.of<TabataBloc>(context).tabataWorkouts.last.description = controller.text;
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
                    child: Text( state.tabataModel.description ?? '',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 40,
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
        return Placeholder(
          fallbackWidth: 300,
          fallbackHeight: 200,
          color: Colors.pink,
        );
    });
  }
}
