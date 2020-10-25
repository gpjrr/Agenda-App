import 'dart:io';
import 'dart:convert';
//import 'dart:html';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agendaprocrastinacion/Task.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}


class _LoadingState extends State<Loading> {
  List<Task> Tareas=new List(0);

  ///void
  void readtask() async{
    try {
      final direc = await getApplicationDocumentsDirectory();

      File doc = File('${direc.path}/SaveTasks.json');

      print(' ===${ doc.readAsString() }');
      List Jarr;
      Jarr = json.decode(await doc.readAsString());
      print('leyo= $Jarr \n');
      for (var item in Jarr) {
        Tareas.add(new Task.fromJson(item));
      }
      for( int i=0;i<Tareas.length;i++)
        print(' $i = ${ Tareas[i] } ');
    } catch(e){
      print('no jaloo por $e');
      Tareas=[];
    }

    Navigator.pushReplacementNamed(context, '/home',arguments: Tareas);
  }
  /*
  void llena() async{
    // probando con algo vaio
    for(int i=1;i<=15;i++) {
      Tareas.add(
       Task(
         Nombre:"ejemplo $i",
         Descripcion: "aqui redacto",
         Dias: List.filled(7, false),
         Lave: UniqueKey(),
         Done: 1*(i%2)==true?true:false,
         Tempo: (i%2)==1?true:false,
         Hora: "00",
         Minu: "01",
       )
     );
    }
    await new Future.delayed(const Duration(seconds : 1));
  }*/

  @override
  void initState() {
    super.initState();
    readtask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child:  SpinKitFadingCircle(
          color: Colors.black,
          size: 50,
        ),
      ),
    );
  }

}
