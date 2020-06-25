import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class Tiempo extends StatefulWidget {
  @override
  _TiempoState createState() => _TiempoState();
}

class _TiempoState extends State<Tiempo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds
          duration: 12000,

          // Width of the Countdown Widget
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget
          height: MediaQuery.of(context).size.height / 2,

          // Default Color for Countdown Timer
          color: Colors.white,

          // Filling Color for Countdown Timer
          fillColor: Colors.red,

          // Border Thickness of the Countdown Circle
          strokeWidth: 5.0,

          // Text Style for Countdown Text
          textStyle: TextStyle(
              fontSize: 22.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),

          // true for reverse countdown (max to 0), false for forward countdown (0 to max)
          isReverse: false,

          // Function which will execute when the Countdown Ends
          onComplete: () {
            // Here, do whatever you want
            print('Countdown Ended');
          },
        )
      )
    );
  }
}
