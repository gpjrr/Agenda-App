import 'dart:io';
import 'dart:convert';
//import 'dart:html';
import 'package:agendaprocrastinacion/Meta.dart';
import 'package:agendaprocrastinacion/UserData.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agendaprocrastinacion/Task.dart';

import 'CustomTimerPainter.dart';


class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> with TickerProviderStateMixin {
  AnimationController controller;
  bool Bandera=false;
  bool Arranque=false;
  bool Final=false;
  int MinutosFinales=0;

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
      WidgetsBinding.instance.addPostFrameCallback((_) => Fun(context,MinutosFinales));
    }

    return TimeOver();
  }
  int ID;
  int Segundos=0;
  List<Task> Tareas=new List();
  UserData Yo;
  void WriteUser()async{

    try {
      final direc = await getApplicationDocumentsDirectory();
      File archivo = File('${direc.path}/SaveUser.json');
      String jText = jsonEncode(Yo);
      print('esto es el yo=$jText');
      await archivo.writeAsString(jText);
    } catch (e) {
      print('no jaloo por ${e}');
    }


  }
  void ReadUser()async {
    try{
      final direc = await getApplicationDocumentsDirectory();
      File doc = File('${direc.path}/SaveUser.json');
      dynamic tem=json.decode(await doc.readAsString());
      print("tem=$tem");
      Yo=UserData().from(tem);
      print('nombreeeee=${Yo.NombreU}');
    }
    catch(e){
      print('usuario error $e');
    }

  }
  void ReadTask()async {
    try {
      final direc = await getApplicationDocumentsDirectory();
      File doc = File('${direc.path}/SaveTasks.json');
      List Jarr;
      print("holaaa\n");
      Jarr = json.decode(await doc.readAsString());
      print("JARR==$Jarr");
      for (var item in Jarr) {
        print("item=$item");
        Task Tem= new Task().from( item );
        Tareas.add(Tem);
        print(" Tem==== $Tem ");
      }

      print('Tareas leidas ${Tareas.length}');
      for( int i=0;i<Tareas.length;i++)
        print(' $i = ${ Tareas[i] } ');
    } catch(e){
      print('no jaloo por $e');
    }
  }
  void WriteTask() async {
    try {
      print('p1\n');
      final direc = await getApplicationDocumentsDirectory();
      print('p2\n');
      File archivo = File('${direc.path}/SaveTasks.json');
      print('p3 ${ Tareas[0].toJson() } \n');

      String jText = jsonEncode(Tareas);
      print('p4\n');
      print('cambio= ${jText} \n');
      await archivo.writeAsString(jText);
    } catch (e) {
      print('no jaloo por ${e}');
    }
  }
  void Fun( BuildContext context ,int tem)async{
    try {
      await ReadTask();
      print("tareas->$Tareas");/*
      for (int i = 0; i < Tareas.length; i++)
        if (Tareas[i].ID == ID) {
          Tareas[i].WDay[ Jiffy().dayOfYear ] = 3;
        }*/
      ///aqui hay error pero es porque no se esta leyendo bien las tareas
      ///instance of tareas raroooo :(

      await WriteTask();
    }
    catch(e){
      print("errror tarea $e");
    }
    /*
    try{
      await ReadUser();
      Yo.DailyTime[ Jiffy().dayOfYear ] += tem;
      await WriteUser();
    }
    catch(e){
      print("errror usuario $e");
    }*/
    Navigator.pushReplacementNamed(context,'/resultado' ,arguments: tem );
  }
  @override
  void initState() {
    Bandera=false;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    if( Bandera==false ){
      Bandera=true;
      dynamic cosa=ModalRoute.of(context).settings.arguments;
      print( " ${cosa['Hora']} =__= ${cosa['Minu']}" );
      ID=cosa['ID'];
      Segundos= int.parse( cosa['Hora'] )*60+int.parse( cosa["Minu"] );
      MinutosFinales=Segundos;
      Segundos*=60;
      controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: Segundos ),
      );
      print("seg==$Segundos");
    }
    ThemeData themeData = Theme.of(context);

    return WillPopScope(
      onWillPop: (){
        if( Arranque==true )
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
      },
      child: Scaffold(
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
      ),
    );
  }
}


