import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;




class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Workout Timer',
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
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Padding(
           padding: const EdgeInsets.only(top: 30.0),
           child: Text("""" If you Don't Find the Time \n   If you Don't Do the Work\n   You Won't get the results " """"",
             style: GoogleFonts.bebasNeue(
               fontSize: 35,
               color: Colors.blueAccent
             ) ,
           ),
         ),
         GestureDetector(
           onTap: (){
             Navigator.pushNamed(context, '/WorkoutClockPage');
           },
           child: Padding(
             padding: const EdgeInsets.only(top: 50),
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
            child: const Text('Notes', style: TextStyle(fontSize: 30, color: Colors.blueAccent),),
          )
        ]
      ),
    );
  }
}
