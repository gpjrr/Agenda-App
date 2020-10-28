import 'dart:ffi';
import 'package:agendaprocrastinacion/Resultado.dart';
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
  bool Bandera=false;
  bool Arranque=false;
  bool Final=false;


  String TimeOver(){
    Duration duration = controller.duration * controller.value;
    String Horas=(duration.inHours).toString().padLeft(2, '0');
    String Minutos=(duration.inMinutes-duration.inHours*60).toString().padLeft(2, '0');
    String Segundos=(duration.inSeconds%60).toString().padLeft(2, '0');
    return '$Horas:$Minutos:$Segundos';
  }
  String get timerString {
    String limpio='00:00:00';
    if( limpio.compareTo( TimeOver() )==0 && Arranque==true ) {
        Final=true;
      controller.stop();
      WidgetsBinding.instance.addPostFrameCallback((_) => Fun(context));
    }

    return TimeOver();
  }
  int Segundos=0;
  @override
  void initState() {
    Bandera=false;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    //print("hola");
    if( Bandera==false ){
      Bandera=true;
      dynamic cosa=ModalRoute.of(context).settings.arguments;
      print( " ${cosa['Hora']} =__= ${cosa['Minu']}" );

      Segundos= int.parse( cosa['Hora'] )*60+int.parse( cosa["Minu"] );
      Segundos*=60;
      controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: Segundos ),
      );
      print("seg==$Segundos");
    }
    /*if( Final==true){
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) => Fun(context));
      }
      catch(e){
        print(' jalo por $e');
      }
      }
    */
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.yellow[500],
                    height:MediaQuery.of(context).size.height,
                    //controller.value *
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
                                        color: Colors.blue[700],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            color: Colors.red,
                            child: FlatButton.icon(
                              onPressed: (){
                                String limpio='00:00:00';
                                if( controller.isAnimating!=true )
                                  Navigator.pop( context,null );
                                else {

                                    //// warning
                                    showDialog(
                                      context: context,
                                      builder: (context)=> AlertDialog(
                                        content: Text(
                                          'Deseas salir sin terminar el tiempo ?',
                                          style: TextStyle(
                                            fontSize: 20,
                                            //fontFamily: 'EastSeaDokdo-Regular',
                                            fontFamily: 'Bellota-BoldItalic',
                                            //fontFamily: 'Peddana-Regular',
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                fontSize: 20,
                                                //fontFamily: 'EastSeaDokdo-Regular',
                                                fontFamily: 'Bellota-BoldItalic',
                                                //fontFamily: 'Peddana-Regular',

                                              ),
                                            ),
                                            onPressed: (){
                                              Navigator.pop(context,null );
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              'Si',
                                              style: TextStyle(
                                                fontSize: 20,
                                                //fontFamily: 'EastSeaDokdo-Regular',
                                                fontFamily: 'Bellota-BoldItalic',
                                                //fontFamily: 'Peddana-Regular',

                                              ),
                                            ),
                                            onPressed: (){
                                              Navigator.pop(context,null );
                                              Navigator.pop(context,null );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                }

                              },
                              label: Text(
                                'Cancelar',
                                style: TextStyle(
                                  fontSize: 20,
                                  //fontFamily: 'EastSeaDokdo-Regular',
                                  fontFamily: 'Bellota-BoldItalic',
                                  //fontFamily: 'Peddana-Regular',

                                ),
                              ),
                              icon: Icon(
                                Icons.cancel,
                                size: 20,
                              ),

                            ),
                          ),
                          AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                return FloatingActionButton.extended(
                                    onPressed: () {
                                      setState(() {
                                        Arranque=true;
                                      });
                                      if (controller.isAnimating)
                                        controller.stop();
                                      else
                                        controller.reverse(
                                            from: controller.value == 0.0 ? 1.0 : controller.value
                                        );
                                    },
                                    icon: Icon(
                                      controller.isAnimating ? Icons.pause : Icons.play_arrow,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      controller.isAnimating ? "Pause" : "Play",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        //fontFamily: 'EastSeaDokdo-Regular',
                                        fontFamily: 'Bellota-BoldItalic',
                                        //fontFamily: 'Peddana-Regular',

                                      ),
                                    )
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}


void Fun( BuildContext context ){

    print('terminoo');
    //Navigator.pop();
    Navigator.pushReplacement(context, new MaterialPageRoute(
        builder: (context) => new Resultado() )
    );
  }