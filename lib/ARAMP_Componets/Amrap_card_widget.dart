import 'package:WorkoutClock/ARAMP_Componets/AMRAP_model.dart';
import 'package:WorkoutClock/ARAMP_Componets/ARAMP_Scroll_Wheel/Amrap_scroll_wheel_widget.dart';
import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../models/motivational_quotes.dart';

class AmrapWorkoutCard extends StatefulWidget {
  AmrapWorkoutCard({super.key, required this.amrapModel, required this.index, required this.testBorderColor});

  int index;
  AmrapModel amrapModel;
  bool testBorderColor;

  @override
  State<AmrapWorkoutCard> createState() => _AmrapWorkoutCardState();
}

  bool borderWhite = true;



class _AmrapWorkoutCardState extends State<AmrapWorkoutCard> {


  late String amrapDescription;

  String AmrapDescription(AmrapModel amrapModel) {
    List<String> description = widget.amrapModel.description!.split(',');
    String updatedDescription = '';
    for (String text in description) {
      updatedDescription += text;
    }
    return updatedDescription;
  }

  @override
  void initState() {
    // TODO: implement initState
    amrapDescription = AmrapDescription(widget.amrapModel);
    super.initState();
    if(widget.testBorderColor == true){
      /// Update Amrap text
      print('\ninitState() - actived ');
      BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: widget.amrapModel.duration, status: AMRAP_Status.selectingWorkout, description: amrapDescription));
    }
  }


  //AmrapModel(duration: 10, description: '\n10 Squats,\n10 Jump Squats,\n10 Lunges,\n10 Jump Lunges'),
  @override
  Widget build(BuildContext context) {

    /// Test Function to split Amrap Model Description
    // List<String> description = widget.amrapModel.description!.split(',');
    // String updatedDescription = '';
    // for(String text in description){
    //   updatedDescription += text;
    // }

    if(widget.index == 0){
      return GestureDetector(
        onTap: (){
          setState(() {

            // if(widget.index != MiddleAreaBloc.amrapWorkoutIndex){
            //   BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Amramp, widgetIndex: widget.index));
            // }

            if(widget.index != MiddleAreaBloc().state.widgetIndex){
              BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Amramp, widgetIndex: widget.index,));
              // BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: 0,
              //     status: AMRAP_Status.selectingWorkout,
              //     description: amrapDescription,
              //     amrapModel: AmrapModel(duration: 10, rounds: 0, description: ''),
              // ));
              /// Test to update Amrap Scroll Wheel
              BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: 0,
                status: AMRAP_Status.initial,
                description: amrapDescription,
                amrapModel: AmrapModel(duration: 10, rounds: 0, description: ''),
              ));
              print('\n${widget.index} Amrap Card in if statement');
            }

            print('\n${widget.index} Amrap Card not in statement');
            // /// Prints Index in Scroll Wheel
            // print('\nAmrap Card index: ${widget.index}');
            // /// Changes Border Color white to green
            // //borderWhite = !borderWhite;
            // widget.testBorderColor = !widget.testBorderColor;
            // /// Change the initial text
            // // BlocProvider.of<AMRAPBloc>(context).add(
            // //     AmrapUpdate(
            // //         duration: 0,
            // //         status: AMRAP_Status.selectingWorkout,
            // //         description: amrapDescription,
            // //         amrapModel: AmrapModel(duration: 10, rounds: 0, description: '')));
            // /// Amrap Middle Area static index Updates after each click
            // /// The index is used to keep the correct Amrap Middle Widget border color
            // MiddleAreaBloc.amrapWorkoutIndex = widget.index;
            //
            // /// Test to Updated Amrap Scroll Wheel
            // BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: 0,
            //   status: AMRAP_Status.initial,
            //   description: amrapDescription,
            //   amrapModel: AmrapModel(duration: 10, rounds: 0, description: ''),
            // ));

          });
        },
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
              border: Border.all(
                //color: borderColor ? Colors.white : Colors.green,
                color: widget.testBorderColor ? Colors.green : Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Custom',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 30,
                          color: Colors.white,
                          textStyle: TextStyle(
                            height: 1.25,
                            overflow: TextOverflow.visible,
                          )
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 21,
                          color: Colors.white,
                        ),
                        //textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: (){
        setState(() {

          //if(widget.index != MiddleAreaBloc.amrapWorkoutIndex){
          //   BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Amramp, widgetIndex: widget.index));
          // }

          if(widget.index != MiddleAreaBloc().state.widgetIndex){
            BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Amramp, widgetIndex: widget.index));
            //BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: widget.amrapModel.duration, status: AMRAP_Status.selectingWorkout, description: amrapDescription, amrapModel: widget.amrapModel));
            //AmrapScrollWheel.duration = widget.amrapModel.duration;
            print('State.duration: ${widget.amrapModel.duration}');
            print('Amrap Card Gesture -> ${widget.amrapModel.duration}');
            AmrapScrollWheel.duration = widget.amrapModel.duration;

            /// Helper Function workout great!
            //BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: widget.amrapModel.duration, status: AMRAP_Status.helper, description: amrapDescription, amrapModel: widget.amrapModel));
            //print('\n${widget.index} Amrap Card in if statement');

            BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: widget.amrapModel.duration, status: AMRAP_Status.helper, description: amrapDescription, amrapModel: widget.amrapModel));
          }

          print('\n${widget.index} Amrap Card not in statement');
          // //print('Amrap Card Gesture -> ${widget.amrapModel.duration}');
          // /// Prints Index in Scroll Wheel
          // print('\nAmrap Card index: ${widget.index}');
          // /// Changes Border Color white to green
          // //borderWhite = !borderWhite;
          // widget.testBorderColor = !widget.testBorderColor;
          // /// Change the initial text
          // BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: widget.amrapModel.duration, status: AMRAP_Status.selectingWorkout, description: amrapDescription, amrapModel: widget.amrapModel));
          // /// Amrap Middle Area static index Updates after each click
          // /// The index is used to keep the correct Amrap Middle Widget border color
          // MiddleAreaBloc.amrapWorkoutIndex = widget.index;
          //
          // /// Update Scroll Wheel
          // AmrapScrollWheel.duration = widget.amrapModel.duration;
          //
          // print('State.duration: ${widget.amrapModel.duration}');

        });


      },
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          border: Border.all(
            //color: borderColor ? Colors.white : Colors.green,
            color: widget.testBorderColor ? Colors.green : Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text(
                      'ARAMP Workout\n${widget.amrapModel.duration} Minutes',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 30,
                          color: Colors.white,
                          textStyle: TextStyle(
                            height: 1.25,
                            overflow: TextOverflow.visible,
                          ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      amrapDescription,
                      style: GoogleFonts.bebasNeue(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


