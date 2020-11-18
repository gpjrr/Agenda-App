import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:agendaprocrastinacion/Task.dart';
import 'package:agendaprocrastinacion/UserData.dart';
import 'package:agendaprocrastinacion/WeekView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agendaprocrastinacion/TipList.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:agendaprocrastinacion/Meta.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<Task> Tareas = new List();
  List<Meta> Metas = new List();
  List< WeekView > Week= new List();
  int TabIndex = 0;
  UserData Yo;
  List<int> colores= [0,2,-1,0,1,3,2];
  //List<Icon> iconos=new List();
  bool ban = false;

  TabController _tabController;
  @override
  void initState() {
    //_tabController.addListener(() { activo=_tabController.index; });
    super.initState();
    _tabController = TabController(length: 2, vsync: this );

    _tabController.addListener(() {
      setState(() {
        TabIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
     });
  }

  void WriteMeta() async {
    try {} catch (e) {
      print('No grabo meta por $e ');
    }
  }
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
  void WriteTask() async {
    try {
      print('p1\n');
      final direc = await getApplicationDocumentsDirectory();
      print('p2\n');
      File archivo = File('${direc.path}/SaveTasks.json');
     /// print('p3 ${ Tareas[0].toJson() } \n');

      String jText = jsonEncode(Tareas);
      print('p4\n');
      print('cambio= ${jText} \n');
      await archivo.writeAsString(jText);
    } catch (e) {
      print('no jaloo por ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ban == false) {
      print("dia del ano= ${Jiffy().dayOfYear}");
      dynamic cosas = ModalRoute.of(context).settings.arguments;

      Tareas = cosas['Tareas'];
      Metas = cosas['Metas'];
      Yo=cosas['Yo'];
      print('tareaaa=${Tareas.length}');
      print('yo=${Yo.TaskCont}');
      Yo.DaysWeek();
     // print('yoDias=${Yo.WeekDay }');
      int HOY=Jiffy().dayOfYear;

      print('hoyDias=${ Jiffy().dayOfYear }');
      for(var cosa in Tareas)
        print("..${ cosa.WDay }");


      ban = true;
      for (int i = 0; i < Tareas.length; i++) {
        Tareas[i].RelojIcono();
        Tareas[i].Lave = UniqueKey();
        //print( ' nor=${Tareas[i].Lave} rara=${ UniqueKey() } ' );
        Week.add( new WeekView( valores: colores ) );
      }

    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(211, 211, 211, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Hola ${Yo.NombreU}=${Yo.DailyTime[Jiffy().dayOfYear]}',
            //'Hola ${Yo.NombreU} ${Yo.TaskCont}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              letterSpacing: 1,
              fontFamily: 'Bellota-BoldItalic',
            ),
          ),
          actions: <Widget>[
            /*Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            ),*/
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text("Editar Nombre",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          letterSpacing: 1,
                          fontFamily: 'Bellota-BoldItalic',
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text("Salir",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          letterSpacing: 1,
                          fontFamily: 'Bellota-BoldItalic',
                        ),
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    print("value:$value");
                    if( value==2 )
                      exit(0);
                    else {
                      setState(() async{
                        dynamic cosa2 = await Navigator.pushNamed(context,'/FirstView');
                        String Nambre=cosa2['Nombre'];
                        Yo.NombreU=Nambre;
                        WriteUser();
                      });


                    }
                  },
                ),
            ),
          ],
          backgroundColor: Colors.yellow[500],
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) {
            //  print("val==${index}");
///              TabIndex = index;
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
           controller: _tabController,
          children: <Widget>[
            SafeArea(
              child: ListView.builder(
                itemCount: Tareas.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 2,
                      ),
                      child: Card(
                        //borderOnForeground: true,
                        child: ListTile(
                          onTap: () async {
                            dynamic cosa2 = await Navigator.pushNamed(
                                context, '/editor',
                                arguments: {
                                  'Nombre': Tareas[index].Nombre,
                                  'Descripcion': Tareas[index].Descripcion,
                                  'Dias': Tareas[index].Dias,
                                  'Tempo': Tareas[index].Tempo,
                                  'Hora': Tareas[index].Hora,
                                  'Minu': Tareas[index].Minu,
                                  'Today': Tareas[index].Today
                                });
                            //print(cosa2);
                            setState(() {
                              Task Sujeto = Task(
                                Nombre: cosa2['Nombre'],
                                Limpio: true,
                                Descripcion: cosa2['Descripcion'],
                                Dias: cosa2['Dias'],
                                Tempo: cosa2['Tempo'],
                                Lave: UniqueKey(),
                                Today: cosa2['Today'],
                                Hora: cosa2['Hora'],
                                Minu: cosa2['Minu'],
                              );
                              Sujeto.RelojIcono();
                              Tareas[index] = Sujeto;
                              WriteTask();
                            });
                          },
                          //tileColor: Colors.blue,
                         /// trailing: Text('${Tareas[index].ID}'),
                          leading: Tareas[index].Reloj,
                          title: Text(
                            Tareas[index].Nombre.substring(
                                0,
                                Tareas[index].Nombre.length >= 18
                                    ? 18
                                    : Tareas[index].Nombre.length),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              letterSpacing: 1,
                              fontFamily: 'EastSeaDokdo-Regular',
                              //fontFamily: 'Caveat-Regular',
                            ),
                          ),
                          //trailing: Tareas[index].Reloj,
                          subtitle:Week[index].Semana(),

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
                    onDismissed: (direction) async {
                      Task tem = Tareas[index];

                      setState(() {
                        print("tam== ${Tareas.length} I=$index");
                        //print("${Tareas[index].Tempo}");
                        print("${Tareas[index].Hora} ${Tareas[index].Minu}");
                        Tareas.removeAt(index);

                      });
                      if (direction == DismissDirection.startToEnd) {
                        try {
                          dynamic work = await Navigator.pushNamed(
                              context, '/tiempo',
                              arguments: {
                                'Hora': tem.Hora,
                                'Minu': tem.Minu,
                                'ID':tem.ID,
                              });
                        } catch (e) {
                          print('no jalo el slide por $e');
                        }
                      }
                      else {
                        await WriteTask();
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
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 2,
                        ),
                        child: Card(
                          child: ListTile(
                              onTap: () async {
                                dynamic cosam = await Navigator.pushNamed(
                                    context, '/editormeta',
                                    arguments: {
                                      'Name': Metas[index].Name,
                                      'Days': Metas[index].Days,
                                      //'Why':Metas[index].Why,
                                      //'StepN':Metas[index].StepN,
                                      'StepD': Metas[index].StepD,
                                    });
                                setState(() {
                                  Meta Sujeto = Meta(
                                    Name: cosam['Name'],
                                    Days: cosam['Days'],
                                    // StepN: cosam['StepN'],
                                    StepD: cosam['StepD'],
                                  );
                                  Metas[index] = Sujeto;
                                });
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
                              )),
                        ),
                      );
                    }))
          ],
        ),


        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            dynamic cosa;

            /// tabindex==0 tareas en 1 metas
            if (TabIndex == 0) {
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
                ID: Yo.TaskCont,
                WDay: new List.filled(400, 0),
              );
             //// print("=-=${Nuevo.ID}");
              Nuevo.Hoy();
              cosa = await Navigator.pushNamed(context, '/editor', arguments: {
                'Nombre': Nuevo.Nombre,
                'Descripcion': Nuevo.Descripcion,
                'Dias': Nuevo.Dias,
                'Tempo': Nuevo.Tempo,
                'Hora': Nuevo.Hora,
                'Minu': Nuevo.Minu,
                'Today': Nuevo.Today,
                'ID':Nuevo.ID,
                'WDay':Nuevo.WDay,
              });
              ///print('tempo--${Nuevo.ID}');
            }
            else {
              Meta Nuevo = new Meta(
                Name: '',
                Days: 0,
                StepD: new List(10),
                Why: '',
                //StepN: 0,
              );
              cosa =
                  await Navigator.pushNamed(context, '/editormeta', arguments: {
                'Name': Nuevo.Name,
                'Days': Nuevo.Days,
                'Why': Nuevo.Why,
                'StepD': Nuevo.StepD,
                //'Progress':Nuevo.Progress, no mandas progreso,
                ///el progreso se calcula y si se regresa
                //'StepN':Nuevo.StepN,
              });
            }

            setState(() {
              print(' indice=${TabIndex}');
              if (cosa != null) {
                if (TabIndex == 0) {
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
                    WDay: cosa['WDay'],
                    //ID: cosa['ID'],
                  );
                  Sujeto.ID= Yo.TaskCont++;
                  Sujeto.RelojIcono();
                  Tareas.add(Sujeto);
                  print('voy a guardar\n');
                  WriteTask();
                  print('guarde las tareas \n');
                  WriteUser();
                  Week.add(new WeekView( valores:colores ));
                } else {
                  /// guardamos lo. que regresa el editor de la meta

                }
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
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new TipList()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
