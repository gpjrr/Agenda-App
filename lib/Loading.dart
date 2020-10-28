import 'dart:io';
import 'dart:convert';
//import 'dart:html';
import 'package:agendaprocrastinacion/Meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agendaprocrastinacion/Task.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<Task> Tareas=new List();
  List<Meta> Metas=new List();

  void readData() async{
    try {
      final direc = await getApplicationDocumentsDirectory();
      File doc = File('${direc.path}/SaveTasks.json');
      List Jarr;
      Jarr = json.decode(await doc.readAsString());
      for (var item in Jarr) {
        Task Tem= new Task().from( item );
        Tareas.add(Tem);
      }
      for( int i=0;i<Tareas.length;i++)
        print(' $i = ${ Tareas[i] } ');
    } catch(e){
      //print('no jaloo por $e');
      Tareas=[];
    }

    for(int i=0;i<5;i++) {
      List<String> prro = ['paso1', 'ps2', 'p3', 'sad'];
      Metas.add(Meta(
        Days: i,
        StepD: prro,
        Why: 'quiero crecer',
        StepN: 4,
        Name: 'Terminar__app ${i+3}',
      ));
    }

    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'Tareas':Tareas,
      'Metas':Metas,
    } );
  }

  @override
  void initState() {
    super.initState();
     readData();
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
