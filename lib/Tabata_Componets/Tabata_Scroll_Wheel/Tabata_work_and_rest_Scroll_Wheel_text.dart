import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabataWorkRestScrollText extends StatelessWidget {
  TabataWorkRestScrollText({super.key, required this.index});

  int index;
  @override
  Widget build(BuildContext context) {
    /// Make conditions
    /// 5,
    // if(index == 0 ){
    //   return Text( '0 -Continuous',
    //     textAlign: TextAlign.center,
    //     style: GoogleFonts.bebasNeue(
    //     fontSize: 30,
    //     letterSpacing: 0,
    //     wordSpacing: 5,
    //     color: Colors.white,)
    //   );
    // }
    if(index <= 54){
      return Text(
        '${index + 5} seconds',
        textAlign: TextAlign.center,
        style: GoogleFonts.bebasNeue(
          fontSize: 30,
          letterSpacing: 0,
          wordSpacing: 5,
          color: Colors.white,)
      );
    }
    if(index >= 55 && index < 91){
      int seconds = ((((index - 55) * 15) + 60) % 60);
      int minutes = ((((index - 55) * 15) + 60) ~/ 60);
      return Text(
          '$minutes:$seconds minutes',
          textAlign: TextAlign.center,
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
            letterSpacing: 0,
            wordSpacing: 5,
            color: Colors.white,)
      );
    }
    if(index >= 91 && index < 141) {
      return Text(
          '${(index - 91) + 10} minutes',
          textAlign: TextAlign.center,
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
            letterSpacing: 0,
            wordSpacing: 5,
            color: Colors.white,)
      );
    }if(index >= 141) {
      int hours = (((index - 141) * 10) + 60) ~/ 60;
      int minutes = (((index - 141) * 10) + 60) % 60;
      return Text(
          '$hours:$minutes hours',
          textAlign: TextAlign.center,
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
            letterSpacing: 0,
            wordSpacing: 5,
            color: Colors.white,)
      );
    }
    return Text(
        index.toString(),
        textAlign: TextAlign.center,
        style: GoogleFonts.bebasNeue(
          fontSize: 30,
          letterSpacing: 0,
          wordSpacing: 5,
          color: Colors.white,)
    );
  }
}
