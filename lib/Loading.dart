import 'dart:io';
import 'dart:convert';
//import 'dart:html';
import 'package:agendaprocrastinacion/Meta.dart';
import 'package:agendaprocrastinacion/UserData.dart';
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
  UserData Yo;
  void WriteUser()async{

    try {
      Yo.DailyTime=new List.filled(400, 0);
      final direc = await getApplicationDocumentsDirectory();
      File archivo = File('${direc.path}/SaveUser.json');
      String jText = jsonEncode(Yo);
      print('esto es el yo=$jText');
      await archivo.writeAsString(jText);
    } catch (e) {
      print('no jaloo por ${e}');
    }

    
  }
  void ReadTask()async{
    try {
      final direc = await getApplicationDocumentsDirectory();
      File doc = File('${direc.path}/SaveTasks.json');
      List Jarr;
      Jarr = json.decode(await doc.readAsString());
      print("JARR= $Jarr");
      for (var item in Jarr) {
        Task Tem= new Task().from( item );
        print("tem de la iteracion $Tem");
        Tareas.add(Tem);
      }
      print('Tareas leidas ${Tareas.length}');
      for( int i=0;i<Tareas.length;i++)
        print(' i=$i = ${ Tareas[i].Nombre } ');
    } catch(e){
      print('no leyo las tareas por  $e');
      Tareas=[];
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
      return;
    }
    catch(e){
      print('usuario error $e');
      /// llevarlo al manual primer acercamiento
      dynamic cosa2 = await Navigator.pushNamed(context,'/FirstView');
      String Nambre=cosa2['Nombre'];
      Yo=new UserData(
        TaskCont: 0,
        NombreU: Nambre,
      );
      print('que es?=$Nambre');
      await WriteUser();
    }

  }

  void ReadData() async{
    await ReadUser();
    await ReadTask();
    for(int i=0;i<5;i++) {
      List<String> prro = ['paso1', 'ps2', 'p3', 'sad'];
      Metas.add(Meta(
        Days: i,
        StepD: prro,
        Why: 'quiero crecer',
        //StepN: 4,
        Name: 'Terminar__app ${i+3}',
      ));
    }

    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'Tareas':Tareas,
      'Metas':Metas,
      'Yo':Yo,
    } );
  }

  @override
  void initState() {
    super.initState();
     ReadData();
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
