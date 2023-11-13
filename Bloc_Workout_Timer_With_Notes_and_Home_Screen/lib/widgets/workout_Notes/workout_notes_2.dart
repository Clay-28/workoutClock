
import 'package:bloc_workout_timer_test_1/bloc/note_bloc/note_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


const MONTHS = {1:'January', 2:'February', 3:'March', 4:'April', 5:'May', 6:'June',
  7:'July', 8:'August', 9:'September', 10:'October', 11:'November', 12:'December'};

String day = DateTime.now().day.toString();
String month = MONTHS[DateTime.now().month].toString();
String year = DateTime.now().year.toString();

class WorkoutNotes2 extends StatelessWidget {
  WorkoutNotes2({super.key});


  TextEditingController controller = TextEditingController(
    text: '$month $day $year\n'
  );

  //String data = context.read<NoteState>().text.toString();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
        return Padding(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
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
                        return Container(
                          //color: Colors.black,
                          height: MediaQuery.of(context).size.height * 0.50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              border: Border.all(color: Colors.blueAccent, width: 3, style: BorderStyle.solid),
                              color: Colors.black
                          ),
                          //color: Colors.white54,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0,20,0,0),
                                child: Center(
                                  child: Text('Notes',
                                    style: GoogleFonts.spaceMono(
                                        fontSize: 20,
                                        color: Colors.blueAccent
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child : Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.33,
                                    child: TextField(
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(25),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white, width: 2),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                      ),
                                      controller: controller,
                                      maxLines: 20,
                                      style: GoogleFonts.spaceMono(
                                          fontSize: 20
                                        ,
                                          color: Colors.blueAccent,
                                          height: 1.5,
                                          wordSpacing: 0.1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  // context.read<TimerBloc>().add(
                                  //                               TimerStarted(duration: state.duration, breakTime: state.breakTime!));
                                  //state.copyWith(text: controller.text);
                                  //print(controller.text);
                                  //print('State.text: ${state.text}');
                                  //print('Controller: ${controller.text}');


                                  state.text = controller.text;

                                  //print('After: ${state.text}');
                                  //context.read<NoteBloc>().add(CloseNote(text: controller.text));
                                  //state.text = controller.text;
                                  Navigator.pop(context);

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
                        );
                      }
                  );
                },
                child: const Text('Add Notes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 23,
                  ),
                ))
        );
      });
  }
}

/// Make Notes larger And bluw
/// Update Larger
/// Note Page larger
/// background color black
/// Update notes to a new font and make bold