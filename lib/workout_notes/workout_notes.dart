
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


  TextEditingController controller = TextEditingController(
    text: 'Notes:\n'
  );

  //String data = context.read<NoteState>().text.toString();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state){
        return Padding(
            padding: EdgeInsets.fromLTRB(0,20,0,0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.33,
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
                                TextButton(
                                  onPressed: (){
                                    state.text = controller.text;

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
                  )),
            )
        );
      });
  }
}

/// Make Notes larger And bluw
/// Update Larger
/// Note Page larger
/// background color black
/// Update notes to a new font and make bold