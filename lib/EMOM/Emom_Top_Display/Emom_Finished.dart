import 'package:WorkoutClock/bloc/Amrap_Emom_Tabata_Bloc/Emom_Bloc/Emom_main_bloc.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import '../../bloc/middle_area_bloc/middle_area_bloc.dart';
import '../../models/confetti.dart';
import '../Emom_Model/Emom_Model_and_Emom_Workouts.dart';
import 'Emom_Clock_Text.dart';
import 'Emom_Rounds_Display.dart';


class EmomFinishedDisplay extends StatefulWidget {
  const EmomFinishedDisplay({super.key});

  @override
  State<EmomFinishedDisplay> createState() => _EmomFinishedDisplayState();
}

class _EmomFinishedDisplayState extends State<EmomFinishedDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChangeDisplay();
  }

  ChangeDisplay(){
    Future.delayed(Duration(milliseconds: 500), (){
      setState(() {
        height_1 = MediaQuery.of(context).size.height * 0.32;
        width_1 = MediaQuery.of(context).size.width * 0.85;
        height_2 = MediaQuery.of(context).size.height * 0.30;
        width_2 = MediaQuery.of(context).size.width * 0.80;
        borderRadius_1 = 10;
        borderRadius_2 = 10;
        invisible = !invisible;
        clockText = !clockText;
      });
    });

  }

  bool invisible = true;
  bool clockText = true;
  Widget visibleWidget = Emom_Completed();
  double height_1 = 230;
  double width_1 = 230;
  double height_2 = 204;
  double width_2 = 204;
  double borderRadius_1 = 240 /2;
  double borderRadius_2 = 200 /2;

  //Widget secondaryWidget = SquareDetails();



  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: height_1,
                width: width_1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius_1)
                    ),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2,
                    )
                ),
              ),
              AnimatedContainer(
                height: height_2,
                width: width_2,
                duration: Duration(seconds: 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius_2)
                    ),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 5,
                    )
                ),
              ),
              AnimatedOpacity(
                  opacity: clockText ? 1 : 0,
                  duration: Duration(seconds: 1),
                  child: clockText ? Text('0:00',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ) : Text('')
              ),
              //invisible ? Text('') : Text('0:00', style: TextStyle(fontSize: 40, color: Colors.white),),
              AnimatedOpacity(
                opacity: invisible ? 0 : 1,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    invisible ?  Text('true') : Emom_Completed_Text(height: height_2, width: width_2,),
                  ],
                ),
              ),

            ],
          ),
        ),

        // ToDo: Add Emom Button and Rounds Display
        AnimatedOpacity(
          opacity: invisible ? 1 : 0,
          duration: const Duration(seconds: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EmomRoundsDisplay(),
              //EmomDurationClockText(),
              Text('0:00', style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                      alignment: Alignment.center,
                      children:[
                        Container(
                          width: 87,
                          height: 87,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: Colors.red, style: BorderStyle.solid)
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            fixedSize: const Size(75, 75),
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            //BlocProvider.of<AMRAPBloc>(context).add(AmrapStart());
                            //print(state.duration);
                            BlocProvider.of<EmomBloc>(context).add(EmomPaused());
                          },
                          child: Center(child: Text(
                            'Stop', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}


class Emom_Completed_Text extends StatelessWidget {
  Emom_Completed_Text({super.key, required this.height, required this.width});
  double height;
  double width;

  // Confetti(duration: 3)
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmomBloc,EmomState>(
      builder: (context, state){
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('EMOM',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text('Workout Completed',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text('${state.emomModel.rounds} Rounds',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text('In ${EmomBloc().state.emomModel.totalDuration! ~/60} Minutes',
                    style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: (){
                            /// By setting full Reset to false, EmomWorkoutNotes are not delete
                            BlocProvider.of<EmomBloc>(context).add(EmomReset(fullReset: false));
                            BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.initial));
                            BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Invisible, widgetIndex: -1));
                          },
                          child: Text('Exit', style: GoogleFonts.bebasNeue(
                            fontSize: 30,
                            color: Colors.red,
                          ),)
                      ),
                      TextButton(
                          onPressed: (){

                            BlocProvider.of<EmomBloc>(context).add(EmomReset(fullReset: false));
                            BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Emom, widgetIndex: -1));

                          },
                          child: Text('Restart', style: GoogleFonts.bebasNeue(
                            fontSize: 30,
                            color: Colors.green,
                          ),)
                      )
                    ],
                  ),
                ],
              ),
            ),
            Confetti(duration: 3)
          ],
        );
      },
    );
  }
}


/*

class SquareDetails extends StatelessWidget {
  SquareDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmomBloc, EmomState>
      (builder: (context, state){
      return Column(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.32,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Colors.green,
                                style: BorderStyle.solid
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                                Radius.circular(25))
                        ),
                      ),
                      //const ClockTimeDisplay(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.30,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                                color: Colors.green,
                                style: BorderStyle.solid
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                                Radius.circular(25))
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        child: CircularCappedProgressIndicator(
                          // backgroundColor: Colors.white54,
                          // color: Colors.green,
                          strokeWidth: 5.0,
                          strokeCap: StrokeCap.round,
                          //value: state.duration / AMRAPBloc.totalDuration,
                        ),

                      ),
                      //const ClockTimeDisplay(),
                      //Amrap_Clock_Text(),
                      // ToDo: Change text into a column
                      Text('AMRAP\nWorkout Completed\n${state.emomModel.rounds} Rounds\nIn ${state.emomModel.totalDuration} Minutes',
                        style: TextStyle(
                          fontSize: 30, color: Colors.white,),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              // width: 2,
                              //color: Colors.white54,
                                style: BorderStyle.solid)),
                      )
                    ],
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('AMRAP\nWorkout Completed\n${state.rounds} Rounds\nIn ${state.emomModel.totalDuration} Minutes',
                  style: TextStyle(
                    fontSize: 30, color: Colors.white,),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: (){
                      BlocProvider.of<AMRAPBloc>(context).add(AmrapClose());
                      BlocProvider.of<WorkoutModesBloc>(context)
                          .add(SelectWorkout(
                          status: WorkoutStatus.initial));
                    },
                    child: Text('Close', style: TextStyle(fontSize: 25, color: Colors.red),)
                ),
                TextButton(
                    onPressed: (){
                      BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: 0, status: AMRAP_Status.initial));
                    },
                    child: Text('Restart', style: TextStyle(fontSize: 25, color: Colors.green),)
                )
              ],
            )
          ]
      );
    });
  }
}


 */

class Emom_Completed extends StatelessWidget {
  Emom_Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmomBloc, EmomState>
      (builder: (context, state){
      return Column(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: const CircularCappedProgressIndicator(
                            backgroundColor: Colors.white54,
                            color: Colors.pink,
                            strokeWidth: 5.0,
                            strokeCap: StrokeCap.round,
                            value: 2
                        ),

                      ),
                      Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 3,
                                color: Colors.pink,
                                style: BorderStyle.solid)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]
      );
    });
  }
}
