import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:agendaprocrastinacion/Task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agendaprocrastinacion/TipList.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:agendaprocrastinacion/Meta.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> Tareas=new List();
  List<Meta> Metas=new List();
  int TabIndex=0;
  TabController _tabController;

  //List<Icon> iconos=new List();
  bool ban=false;

  @override
  void initState(){
    //_tabController.addListener(() { activo=_tabController.index; });
    super.initState();
  }

  writeTask() async {
    try {
      ///print('p1\n');
      final direc = await getApplicationDocumentsDirectory();
      //print('p2\n');
      File archivo = File('${direc.path}/SaveTasks.json');
      //print('p3 ${ Tareas[0].toJson() } \n');

      String jText = jsonEncode( Tareas );
      //print('p4\n');
      //print('cambio= ${jText} \n');
      await archivo.writeAsString(jText);
    }
    catch(e){
      print('no jaloo por ${e}');
      }

    }

  @override
  Widget build(BuildContext context) {

    if( ban==false ){
      dynamic cosas=ModalRoute.of(context).settings.arguments;
      Tareas=cosas['Tareas'];
      Metas=cosas['Metas'];
      ban=true;
      for(int i=0;i<Tareas.length;i++) {
        Tareas[i].RelojIcono();
        Tareas[i].Lave = UniqueKey();
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(211, 211, 211, 1) ,
        appBar: AppBar(
          iconTheme: IconThemeData( color: Colors.black ),
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              letterSpacing: 1,
              fontFamily: 'Bellota-BoldItalic',
            ),
          ),
          backgroundColor: Colors.yellow[500],
          bottom: TabBar(
            ///controller: _tabController,
            onTap: (index){
              print("val==${index}");
              TabIndex=index;
            },
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Tareas',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 1,
                    fontFamily: 'Bellota-BoldItalic',
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Metas',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 1,
                    fontFamily: 'Bellota-BoldItalic',
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          /// controller: _tabController,
          children: <Widget>[
            SafeArea(
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
                              Sujeto.RelojIcono();
                              Tareas[index]=Sujeto;
                              writeTask();
                            });
                          },
                          leading:Tareas[index].Reloj,
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
                          //trailing: Tareas[index].Reloj,
                          subtitle: WeekdaySelector(
                            fillColor: Colors.white,
                            firstDayOfWeek: 1,
                            /// letra del color
                            color: Colors.black,
                            selectedFillColor: Colors.blue[700],

                            onChanged: (int day) {
                              setState(() {
                              });
                            },
                            values: Tareas[index].Dias,
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
                      Task tem=Tareas[index];
                      setState(() {

                      print("tam== ${Tareas.length} I=$index");
                      //print("${Tareas[index].Tempo}");
                      print("${Tareas[index].Hora} ${Tareas[index].Minu}");

                        Tareas.removeAt(index);
                      });
                      if(  direction==DismissDirection.startToEnd ) {
                        try {
                          dynamic work = await Navigator.pushNamed(
                              context, '/tiempo', arguments: {
                            'Hora': tem.Hora,
                            'Minu': tem.Minu,
                          });
                        }
                        catch(e){
                          print('no jalo por $e');
                        }
                      }
                      /// aqui borramos la tarea peroo creo no requiere




                    },
                  );
                },

              ),
            ),
            SafeArea(
                child: ListView.builder(
                    itemCount: Metas.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 2,
                        ),
                        child: Card(
                          child: ListTile(
                              onTap: (){

                              },
                              title: Text(
                                Metas[index].Name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  letterSpacing: 1,
                                  fontFamily: 'EastSeaDokdo-Regular',
                                  //fontFamily: 'Caveat-Regular',
                                ),
                              )
                          ),
                        ),
                      );
                    }
                )
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            dynamic cosa;
            /// tabindex==0 tareas en 1 metas
            if( TabIndex==0 ) {
              Task Nuevo = Task(
                Nombre: '',
                Descripcion: "",
                Limpio: true,
                Hora: "00",
                Minu: "00",
                Dias: List.filled(7, false),
                Lave: UniqueKey(),
                Tempo: false,
                Today: true,
              );
              ///print("=-=${Nuevo.Tempo}");
              Nuevo.Hoy();
              cosa = await Navigator.pushNamed(
                  context, '/editor', arguments: {
                'Nombre': Nuevo.Nombre,
                'Descripcion': Nuevo.Descripcion,
                'Dias': Nuevo.Dias,
                'Tempo': Nuevo.Tempo,
                'Hora': Nuevo.Hora,
                'Minu': Nuevo.Minu,
                'Today': Nuevo.Today,
              });
              print('tempo--${Nuevo.Tempo}');
            }
            else{

              Meta Nuevo=new Meta(
                Days:0,
                Why:'',
                StepD: new List(10),
                StepN: 0,
                Name: '',
              );
              cosa=await Navigator.pushNamed(context, '/editormeta' , arguments: {
                'Days':Nuevo.Days,
                'Name':Nuevo.Name,
                'Why':Nuevo.Why,
                'StepN':Nuevo.StepN,
                'StepD':Nuevo.StepD,
                'Progress':Nuevo.Progress,
              });
            }
            setState( (){
              print(' indice=${TabIndex}');
              if( TabIndex==0 ) {
                if (cosa != null) {
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
                  Sujeto.RelojIcono();
                  Tareas.add(Sujeto);
                  print('voy a guardar\n');
                  writeTask();
                }
              }
              else {

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
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new TipList() )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );


  }
}
