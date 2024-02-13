import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabataRoundsScrollText extends StatelessWidget {
  TabataRoundsScrollText({super.key, required this.rounds});

  int rounds;
  @override
  Widget build(BuildContext context) {
    return Text(
        '${rounds+1} rounds',
        textAlign: TextAlign.center,
        style: GoogleFonts.bebasNeue(
          fontSize: 30,
          letterSpacing: 0,
          wordSpacing: 5,
          color: Colors.white,)
    );
  }
}
