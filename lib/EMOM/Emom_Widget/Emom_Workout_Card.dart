import 'package:WorkoutClock/EMOM/Emom_Model/Emom_Model_and_Emom_Workouts.dart';
import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EmomWorkoutCard extends StatefulWidget {
  EmomWorkoutCard({super.key, required this.index, required this.emomModel, required this.testBorderColor});

  int index;
  EmomModel emomModel;
  bool testBorderColor;

  @override
  State<EmomWorkoutCard> createState() => _EmomWorkoutCardState();
}

class _EmomWorkoutCardState extends State<EmomWorkoutCard> {


  late String emomDescription;

  String EmomDescription(EmomModel emomModel) {
    List<String> description = widget.emomModel.description!.split(',');
    String updatedDescription = '';
    for (String text in description) {
      updatedDescription += text;
    }
    return updatedDescription;
  }

  @override
  void initState() {
    // TODO: implement initState
    emomDescription = EmomDescription(widget.emomModel);
    super.initState();
    if(widget.testBorderColor == true){
      /// Update Amrap text
      //BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: widget.amrapModel.duration, status: AMRAP_Status.selectingWorkout, description: amrapDescription));
    }
  }


  @override
  Widget build(BuildContext context) {

    int everyScrollWheelIndex = BlocProvider.of<EmomBloc>(context).state.everyScrollWheelIndex!;
    int forScrollWheelIndex = BlocProvider.of<EmomBloc>(context).state.forScrollWheelIndex!;


    if (widget.index == 0) {
      return GestureDetector(
        onTap: () {
          setState(() {
            widget.testBorderColor = !widget.testBorderColor;
            print(widget.index);
          });
          BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Emom, emomWorkoutIndex: widget.index,));
          // BlocProvider.of<EmomBloc>(context).add(EmomUpdate(
          //   emomStatus: EmomStatus.setup,
          //   everyScrollWheelIndex: everyScrollWheelIndex,
          //   forScrollWheelIndex: forScrollWheelIndex,
         // ));
          /// Changes Emom state to custom and sets the for and every scroll text to original
          BlocProvider.of<EmomBloc>(context).add(EmomUpdate(
            /// Original
            //emomStatus: EmomStatus.setup,
            /// Testing EmomStatus Change
            //emomStatus: EmomStatus.selectingWorkout,
            /// ToDo: Change to emomStatus to Custom and set forScrollWheel Text and scrollWheelText to Original
            emomStatus: EmomStatus.helper,
            description: 'reset',
            emomModel: EmomModel(interval: 60, totalDuration: 10 * 60, description: '', rounds: 0),
            everyScrollWheelIndex: 3,
            everyController: FixedExtentScrollController(initialItem: 3),
            forScrollWheelIndex: 9,
          ));


        },
        child: Container(
          height: 150,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.45,
          decoration: BoxDecoration(
              border: Border.all(
                color: widget.testBorderColor ? Colors.blueAccent : Colors
                    .white,
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
    /// Cards creates from Emom Workouts
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.testBorderColor = !widget.testBorderColor;
          print(widget.index);
        });
        BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Emom, emomWorkoutIndex: widget.index,));
        BlocProvider.of<EmomBloc>(context).add(EmomUpdate(
          interval: widget.emomModel.interval,
          totalDuration: widget.emomModel.totalDuration,
          /// Original
          //emomStatus: EmomStatus.setup,
          /// Testing EmomStatus Change
          //emomStatus: EmomStatus.selectingWorkout,
          /// Testing Helper Function
          emomStatus: EmomStatus.helper,
          emomModel: widget.emomModel,
        ));

        },
      child: Container(
        height: 150,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.45,
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.testBorderColor ? Colors.blueAccent : Colors
                  .white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  'EMOM Workout\n${widget.emomModel.totalDuration!~/60} Minutes',
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
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText( emomDescription,
                  minFontSize: 15,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 35,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
