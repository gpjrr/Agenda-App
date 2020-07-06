import 'dart:math';
import 'dart:ui';
import 'package:agendaprocrastinacion/Task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> Tareas=new List();
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Tareas=Tareas.isNotEmpty?Tareas:ModalRoute.of(context).settings.arguments;
    /*for(int i=0;i<Tareas.length;i++)
      print( " $i =  ${Tareas[i].Nombre}" );*/
    return Scaffold(
      backgroundColor: Color.fromRGBO(211, 211, 211, 1) ,
      appBar: AppBar(
        iconTheme: IconThemeData( color: Colors.black ),
        centerTitle: true,
        title: Text(
          'lista de tareas',
          style: TextStyle(
            color: Colors.black,
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
            return Dismissible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 2,
                ),
                child: Card(
                  //borderOnForeground: true,
                  child: ListTile(
                    onTap: ()async{

                      dynamic cosa2=await Navigator.pushNamed(context,'/editor',arguments: {
                        'Nombre': Tareas[index].Nombre ,
                        'Descripcion': Tareas[index].Descripcion ,
                        'Dias':Tareas[index].Dias,
                        'Tempo':Tareas[index].Tempo,
                        'Hora':Tareas[index].Hora,
                        'Minu':Tareas[index].Minu,
                        'Today':Tareas[index].Today
                      } );
                      //print(cosa2);
                      setState( (){

                        Task Sujeto=Task(
                          Nombre: cosa2['Nombre'],
                          Limpio: true,
                          Descripcion: cosa2['Descripcion'],
                          Dias:  cosa2['Dias'] ,
                          Tempo: cosa2['Tempo'],
                          Lave: UniqueKey(),
                          Today: cosa2['Today'],
                          Hora: cosa2['Hora'],
                          Minu: cosa2['Minu'],
                        );
                        print("H=${Sujeto.Hora} M=${Sujeto.Minu}  ");
                        Tareas[index]=Sujeto;
                      });


                    },
                    leading: Icon( Icons.people ),
                    title: Text(
                        Tareas[index].Nombre.substring(0, Tareas[index].Nombre.length>=18?18:Tareas[index].Nombre.length  ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          letterSpacing: 1,
                          fontFamily: 'EastSeaDokdo-Regular',
                          //fontFamily: 'Caveat-Regular',
                        ),
                    ),
                    trailing: Icon(
                      Icons.done,
                      size: 40,
                      color: Colors.green,
                    ),

                  ),
                ),
              ),
              key: Tareas[index].Lave,
              secondaryBackground: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(

                    Icons.delete,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              background: Container(
                color: Colors.green,
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(

                    Icons.flag,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              onDismissed: ( direction ) async{
                if(  direction==DismissDirection.startToEnd ) {
                  dynamic work = await Navigator.pushNamed(
                      context, '/tiempo', arguments: {
                    'Hora': Tareas[index].Hora,
                    'Minu': Tareas[index].Minu,
                  });
                }

                  setState(() {
                    /*
                    print("tam== ${Tareas.length} I=$index");
                    print("${Tareas[index].Tempo}");
                    print("${Tareas[index].Hora} ${Tareas[index].Minu}");
                    */
                    Tareas.removeAt(index);
                  });

                  },
            );
          },

        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Task Nuevo=Task(
            Nombre: '',
            Descripcion: "",
            Limpio: true,
            Hora: "00",
            Minu: "00",
            Dias: List.filled(7, false),
            Lave: UniqueKey(),
            Tempo: false,
            Today:true,
          );
          ///print("=-=${Nuevo.Tempo}");
          Nuevo.Hoy();
          dynamic cosa=await Navigator.pushNamed(context,'/editor',arguments: {
            'Nombre': Nuevo.Nombre ,
            'Descripcion': Nuevo.Descripcion ,
            'Dias':Nuevo.Dias,
            'Tempo':Nuevo.Tempo,
            'Hora':Nuevo.Hora,
            'Minu':Nuevo.Minu,
            'Today':Nuevo.Today,
          } );
          setState( (){
            if( cosa!=null ) {
              Task Sujeto = Task(
                Nombre: cosa['Nombre'],
                Limpio: true,
                Descripcion: cosa['Descripcion'],
                Dias: cosa['Dias'],
                Tempo: cosa['Tempo'],
                Lave: UniqueKey(),
                Today: cosa['Today'],
                Hora: cosa['Hora'],
                Minu: cosa['Minu'],
              );
              Tareas.add(Sujeto);
            }
          });
        },
        backgroundColor: Colors.blue[700],
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
