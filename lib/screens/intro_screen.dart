
import 'package:WorkoutClock/screens/home_page.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
class IntroScreen extends StatefulWidget {
  IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  //bool _invisible = true;
  bool _greenCircle = true;
  bool _blueCircle = true;
  bool _redCircle = true;

  //AnimationController _test;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      setState(() {
        //_invisible = !_invisible;
        _greenCircle = !_greenCircle;
        _blueCircle = !_blueCircle;
        _redCircle = !_redCircle;
      });

    });




    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.of(context).pushNamed('/HomePage');
    });
  }


  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.black,
      onInit: () {
        //debugPrint("On Init");
      },
      onEnd: () {
        //debugPrint("On End");
      },
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              /// Green Circle
              AnimatedOpacity(
                curve: Curves.easeIn,
                opacity: _greenCircle ? 0 :1,
                duration: Duration(milliseconds: 500 + ( 0 * 500)),
                child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: 210,
                        height: 210,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 7, color: Colors.green, style: BorderStyle.solid)
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
                      //const Text("Workout", style: TextStyle(fontSize: 30, color: Colors.white),)
                    ]),
              ),
              /// Blue Circle
              Positioned(
                bottom: -25,
                right: 0,
                child: AnimatedOpacity(
                  curve: Curves.easeIn,
                  opacity: _blueCircle ? 0 :1,
                  duration: const Duration(milliseconds: 500 + ( 1 * 500)),
                  child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 190,
                          height: 190,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(width: 2, color: Colors.blueAccent, style: BorderStyle.solid)
                          ),
                        ),
                        Container(
                          width: 175,
                          height: 175,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 5, color: Colors.blueAccent, style: BorderStyle.solid)
                          ),
                        ),
                      ]),
                ),
              ),
              /// Red Circle
              Positioned(
                top: 0,
                right: -25,
                child: AnimatedOpacity(
                  curve: const Interval(0,1,curve: Curves.easeIn),
                  opacity: _redCircle ? 0 :1,
                  duration: const Duration(milliseconds: 500 + ( 3 * 500)),
                  child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(width: 2, color: Colors.red, style: BorderStyle.solid)
                          ),
                        ),
                        Container(
                          width: 135,
                          height: 135,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 5, color: Colors.red, style: BorderStyle.solid)
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
