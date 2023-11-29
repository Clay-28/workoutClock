
import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/quotes.dart';
import 'user_workout_notes_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Workout Rest & Go',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.blueAccent, Colors.black],
                stops: [-0.5,0.5,1.5]
              )
            ),
          ),
          /// Added to test the launch screen animation
          /*
          actions: [
            IconButton(
                onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroScreen())); },
                icon: Icon(Icons.add, size: 25, color: Colors.white,))
          ],

           */
          automaticallyImplyLeading: false,
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Padding(
             padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
             child: Center(
               child: Text( Quotes().randomQuote().first,
                 style: GoogleFonts.bebasNeue(
                   fontSize: 35,
                   color: Colors.blueAccent
                 ) ,
               ),
             ),
           ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text( '-${Quotes().randomQuote().last}',
                style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    color: Colors.blueAccent
                ) ,
              ),
            ),
           GestureDetector(
             onTap: (){
               Navigator.pushNamed(context, '/WorkoutClockPage');
             },
             child: Padding(
               padding: const EdgeInsets.only(top: 30),
               child: Center(
                 child: Stack(
                     alignment: AlignmentDirectional.center,
                     children: [
                       Container(
                         width: 200,
                         height: 200,
                         child: const CircularCappedProgressIndicator(
                           backgroundColor: Colors.green,
                           strokeWidth: 5.0,
                           strokeCap: StrokeCap.round,
                           value: 0,
                         ),
                       ),
                         Center(
                           child: Transform.rotate(
                             angle: 2.35, //math.pi / 2,
                             child: const Icon(Icons.fitness_center_rounded,
                               size: 90,
                               color: Colors.green,
                             ),
                           ),
                         ),
                       Container(
                         width: 230,
                         height: 230,
                         decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(width: 2, color: Colors.green, style: BorderStyle.solid)
                         ),
                       ),
                     ]),
               ),
             )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=> const UserWorkoutNotesPage())
                  );
                },
                child: Text('Notes',
                  style: GoogleFonts.bebasNeue(
                  fontSize: 35,
                  letterSpacing: 2.5,
                  color: Colors.blueAccent,
                  ),
                ),
              )
            )
          ]
        ),
      ),
    );
  }
}
