
import 'package:bloc_workout_timer_test_1/bloc/note_bloc/note_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutNotes extends StatelessWidget {
  WorkoutNotes({super.key});

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0,20,0,0),
          child: TextButton(
              onPressed: (){
                showBottomSheet(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  context: context,
                  builder: (context){
                      return Container(
                        //color: Colors.black,
                        height: MediaQuery.of(context).size.height * 0.53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.blueAccent, width: 3, style: BorderStyle.solid),
                          color: Colors.black
                        ),
                        //color: Colors.white54,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0,20,0,0),
                              child: Center(
                                child: Text('Notes',
                                  style: TextStyle(
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
                                  height: MediaQuery.of(context).size.height * 0.35,
                                  child: TextField(
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                      ),
                                    ),
                                    controller: _controller,
                                    maxLines: 100,
                                    style: const TextStyle(
                                      fontSize: 23,
                                      color: Colors.blueAccent
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  state.copyWith(text: _controller.toString());
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

