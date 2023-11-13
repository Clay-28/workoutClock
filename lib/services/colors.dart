import 'dart:ui';
import 'package:flutter/material.dart';

class ColorsPallet{

   Map colorPallet = {
    1: Colors.blueAccent,
    2: Colors.limeAccent,
    3: Colors.pinkAccent,
    4: Colors.deepPurple,
    5: Colors.green,
    6: Colors.tealAccent,
    7: Colors.red
  };

  Color fetchColor(int? index){
    if(index! < 8 && index! >=0) {
      return colorPallet[index];
    }else{
      return Colors.cyanAccent;
    }

  }


}