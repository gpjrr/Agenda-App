import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import 'CustomTimerPainter.dart';
class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    String Horas=(duration.inHours).toString().padLeft(2, '0');
    String Minutos=(duration.inMinutes-duration.inHours*60).toString().padLeft(2, '0');
    String Segundos=(duration.inSeconds%60).toString().padLeft(2, '0');
    return '$Horas:$Minutos:$Segundos';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds:7200),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white10,
      body:
      AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.yellow[500],
                    height:
                    controller.value * MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                        animation: controller,
                                        backgroundColor: Colors.black,
                                        color: themeData.indicatorColor,
                                      )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Tiempo restante",
                                        style: TextStyle(
                                            fontSize: 40.0,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 80.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return FloatingActionButton.extended(
                                onPressed: () {
                                  if (controller.isAnimating)
                                    controller.stop();
                                  else
                                    controller.reverse(
                                        from: controller.value == 0.0 ? 1.0 : controller.value
                                    );
                                },
                                icon: Icon(
                                    controller.isAnimating ? Icons.pause : Icons.play_arrow),
                                label: Text(
                                    controller.isAnimating ? "Pause" : "Play")
                            );
                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}