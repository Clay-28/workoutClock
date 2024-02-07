
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


import '../bloc/note_bloc/note_bloc.dart';
import '../models/months.dart';



String day = DateTime.now().day.toString();
String month = Month().fetchMonth(DateTime.now().month);
String year = DateTime.now().year.toString();

class WorkoutNotes extends StatelessWidget {
  WorkoutNotes({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state){
          if (state.noteStatus == NoteStatus.hidden){
            return Padding(
                padding: EdgeInsets.fromLTRB(0,20,0,0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: MaterialButton(
                      animationDuration: const Duration(seconds: 0),
                      splashColor: Colors.black,
                      onPressed: (){
                      },
                      child: const Text('\n',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 23,
                        ),
                      )),
                )
            );
          }




          if(state.noteStatus == NoteStatus.open){


            return Padding(
                padding: EdgeInsets.fromLTRB(0,20,0,0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: MaterialButton(
                      onPressed: (){
                        showBottomSheet(
                            enableDrag: false,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            context: context,
                            builder: (context){
                              /// Original
                              //return Workout_Notes_Bottom_Sheet(state: state, controller: state.controller, context: context,);
                              /// Updated
                              return Workout_Notes_Bottom_Sheet(controller: state.controller,);
                            }
                        );
                      },
                      child: const Text('Add Notes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 23,
                        ),
                      )),
                )
            );
          }


          return Placeholder(
            fallbackHeight: 100,
            fallbackWidth: 100,
            color: Colors.pink.shade200,
          );
        });
  }
}

class Workout_Notes_Bottom_Sheet extends StatelessWidget {
  Workout_Notes_Bottom_Sheet({super.key, required this.controller,});

  //NoteState state;
  TextEditingController controller;
  //BuildContext context;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.47,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top:Radius.circular(50)),
          border: Border.all(color: Colors.blueAccent, width: 3, style: BorderStyle.solid),
          color: Colors.black
      ),
      //color: Colors.white54,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            child: Center(
              child: Text('$month $day $year',
                style: GoogleFonts.spaceMono(
                    fontSize: 20,
                    color: Colors.blueAccent
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child : Container(
              height: MediaQuery.of(context).size.height * 0.30,
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                /// Original
                controller: controller,
                maxLines: 250,
                style: GoogleFonts.spaceMono(
                  fontSize: 16
                  ,
                  color: Colors.white,
                  height: 1.5,
                  wordSpacing: 0.1,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.pop(context);
              //NoteBloc().add(UpdateNotes(text: '123'));
              BlocProvider.of<NoteBloc>(context).add(UpdateNotes(text: controller.text));
              //locProvider.of<TimerBloc>(context).add(UpdateBreakTime(restMinutes: 1, restSeconds: 30));
              //BlocProvider.of<NoteBloc>(context).add(UpdateNotes(text: controller.text));
            },
            child: const Text('Update',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent
              ),
            ),
          )
        ],
      ),
    );;
  }
}
