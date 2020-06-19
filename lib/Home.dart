import 'dart:ui';

import 'package:agendaprocrastinacion/Task.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> Tareas=new List();
  @override
  void initState()  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Tareas=Tareas.isNotEmpty?Tareas:ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color.fromRGBO(155,155,155, 1),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'lista de tareas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 1,
            fontFamily: 'Bellota-BoldItalic',
          ),
        ),
        backgroundColor: Colors.yellow[500],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: Tareas.length,
          itemBuilder: (context,index){
            return ListTile(
              onTap: (){
                print(" ${Tareas[index].Nombre} ");
              },
              leading: Icon( Icons.people ),
              title: Text(
                  Tareas[index].Nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    letterSpacing: 1,
                    fontFamily: 'EastSeaDokdo-Regular',
                    //fontFamily: 'Caveat-Regular',
                  ),
              ),
              trailing: Icon( Icons.beenhere ),
            );
          },

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Task Nuevo=Task(
            Nombre:"pruebaa",
            Descripcion: "esto es una popo peroo puede funcionar",
            Limpio: true,
            Dias: List.filled(7, false),
            Lave: "0",
          );

          Nuevo.Hoy();
          Nuevo.Dias[0]=true;
          await Navigator.pushNamed(context,'/editor',arguments: {
            'Nombre': Nuevo.Nombre ,
            'Descripcion': Nuevo.Descripcion ,
            'Dias':Nuevo.Dias,
          } );
          setState( (){
            Task Sujeto=Task(
              Nombre: 'asdf',
              Limpio: true,
              Descripcion: 'sfdf',
              Dias: List.filled(7, false),
              Lave: "0",
            );
            Tareas.add(Sujeto);
          });
        },
        backgroundColor: Colors.purple,
        child: Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Tips'),
              trailing: Icon(
                Icons.lightbulb_outline,
                color: Colors.yellow,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Records'),
              trailing: Icon(
                Icons.book,
                color: Colors.brown,
              ),
              onTap: (){
                Navigator.pushNamed(context, '/TipList'  );
              },
            ),
          ],
        ),
      ),
    );


  }
}
