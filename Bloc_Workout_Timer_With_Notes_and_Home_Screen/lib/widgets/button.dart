import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/clock_bloc.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({
    super.key,
    required this.title,
    required this.color,
    required this.function});

  final String title;
  final Color color;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        fixedSize: const Size(75, 75),
        shape: const CircleBorder(),
      ),
      onPressed: () {
       function;
      },
      child: Center(
          child: Text(title, style: const TextStyle(color: Colors.white),)),
    );
  }
}
