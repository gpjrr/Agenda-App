import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agendaprocrastinacion/Task.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}


class _LoadingState extends State<Loading> {
  List<Task> Tareas=new List();

  void llena() async{
    for(int i=1;i<=16;i++) {
      bool tem;
      if( i%2==0 )
        tem=true;
      else tem=false;

      Tareas.add(
       Task(
         Nombre:"ejemplo $i",
         Descripcion: "aqui redacto",
         Dias: List.filled(7, false),
         Lave: "${i} ",
         Done: !tem,
         Tempo: tem,
       )
     );
    }
    await new Future.delayed(const Duration(seconds : 1));
    Navigator.pushReplacementNamed(context, '/home',arguments: Tareas);
  }

  @override
  void initState() {
    super.initState();
    llena();
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
