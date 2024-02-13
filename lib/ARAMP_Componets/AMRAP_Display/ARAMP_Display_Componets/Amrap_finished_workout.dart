import 'package:WorkoutClock/bloc/middle_area_bloc/middle_area_bloc.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../bloc/Amrap_Emom_Tabata_Bloc/ARAMP_Bloc/AMRAP_bloc.dart';
import '../../../bloc/Amrap_Emom_Tabata_Bloc/Modes_Bloc/modes_bloc.dart';
import '../../../models/confetti.dart';
import '../../AMRAP_model.dart';
import '../../Amrap_Clock_Text.dart';
import 'Amrap_rounds.dart';


class Amrap_finished_display extends StatefulWidget {
  Amrap_finished_display({super.key, required this.state});
  AMRAPState state;



  @override
  State<Amrap_finished_display> createState() => _Amrap_finished_displayState();
}

class _Amrap_finished_displayState extends State<Amrap_finished_display> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChangeDisplay();
  }

  void ChangeDisplay(){
    Future.delayed(Duration(milliseconds: 100), (){
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
  Widget visibleWidget = Amrap_Completed();
  double height_1 = 230;
  double width_1 = 230;
  double height_2 = 205;
  double width_2 = 205;
  double borderRadius_1 = 240 /2;
  double borderRadius_2 = 205 /2;

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
              color: Colors.green,
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
                color: Colors.green,
                width: 5,
              )
          ),
        ),
         AnimatedOpacity(
           opacity: clockText ? 1 : 0,
           duration: Duration(seconds: 1),
           child: clockText ? Text('0:00',
             style: TextStyle(
               fontSize: 40, color: Colors.white,),
             textAlign: TextAlign.center,
           ) : Text('')
         ),
         //invisible ? Text('') : Text('0:00', style: TextStyle(fontSize: 40, color: Colors.white),),
        AnimatedOpacity(
          opacity: invisible ? 0 : 1,
          duration: const Duration(seconds: 1),
          child: Column(
            children: [
              invisible ?  Text('true') : Amrap_Completed_Text(height: height_2, width: width_2,),
            ],
          ),
        ),
      ],
    ),
    ),
        AnimatedOpacity(
          opacity: invisible ? 1 : 0,
          duration: const Duration(seconds: 1),
          child: Stack(
            children: [
              Container(
                height : 87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AmrapRoundsDisplay(),
                  ],
                ),
              ),
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
                            null;
                          },
                          child: Center(child: Text(
                            'Stop', style: TextStyle(color: Colors.white),)),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        )]
    );
  }
}


class Amrap_Completed_Text extends StatelessWidget {
  Amrap_Completed_Text({super.key, required this.height, required this.width});
  double height;
  double width;

  // Confetti(duration: 3)
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AMRAPBloc,AMRAPState>(
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
              Text('AMRAP',
                style: TextStyle(
                  fontSize: 30, color: Colors.white,),
                textAlign: TextAlign.center,
              ),
              Text('Workout Completed',
                style: TextStyle(
                  fontSize: 25, color: Colors.white,),
                textAlign: TextAlign.center,
              ),
              Text('${state.rounds} Rounds',
                style: TextStyle(
                  fontSize: 25, color: Colors.white,),
                textAlign: TextAlign.center,
              ),
              Text('In ${AMRAPBloc.totalDuration} Minutes',
                style: TextStyle(
                  fontSize: 25, color: Colors.white,),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: (){
                        BlocProvider.of<AMRAPBloc>(context).add(AmrapClose());
                        BlocProvider.of<WorkoutModesBloc>(context).add(SelectWorkout(status: WorkoutStatus.initial));
                        BlocProvider.of<MiddleAreaBloc>(context).add(MiddleAreaUpdateState(status: MiddleAreaStatus.Invisible, widgetIndex: -1));
                      },
                      child: Text('Exit', style: TextStyle(fontSize: 25, color: Colors.red),)
                  ),
                  TextButton(
                      onPressed: (){
                        BlocProvider.of<AMRAPBloc>(context).add(AmrapUpdate(duration: 0, status: AMRAP_Status.initial, amrapModel: AmrapModel(duration: 10, rounds: 0, description: '') ));
                      },
                      child: Text('Restart', style: TextStyle(fontSize: 25, color: Colors.green),)
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
    return BlocBuilder<AMRAPBloc, AMRAPState>
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
                            value: state.duration / AMRAPBloc.totalDuration,
                          ),

                        ),
                        //const ClockTimeDisplay(),
                        //Amrap_Clock_Text(),
                        // ToDo: Change text into a column
                        Text('AMRAP\nWorkout Completed\n${state.rounds} Rounds\nIn ${AMRAPBloc.totalDuration} Minutes',
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
                  Text('AMRAP\nWorkout Completed\n${state.rounds} Rounds\nIn ${AMRAPBloc.totalDuration} Minutes',
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

class Amrap_Completed extends StatelessWidget {
  Amrap_Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AMRAPBloc, AMRAPState>
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
                          color: Colors.green,
                          strokeWidth: 5.0,
                          strokeCap: StrokeCap.round,
                          value: 1
                        ),

                      ),
                      Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.white54,
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
