import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmrapScrollWheelText extends StatelessWidget {
  const AmrapScrollWheelText({super.key, required this.minutes});
  final int minutes;

  @override
  Widget build(BuildContext context) {
    /// Starting at index 0
    /// 0, 1, 2, f(index * 15 + 15)
    /// 15, 30, 45,  1min
    /// index == 0 0:15 secs
    /// 0:30, 0:45 : sec if index < 3

    return Text(
      '${minutes.toString()} min',
      textAlign: TextAlign.center,
      style: GoogleFonts.bebasNeue(
      fontSize: 30,
      letterSpacing: 0,
      wordSpacing: 5,
      color: Colors.white,)
    );
  }
}
