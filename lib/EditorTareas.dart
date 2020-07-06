import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:agendaprocrastinacion/Task.dart';
class EditorTareas extends StatefulWidget {
  @override
  _EditorTareasState createState() => _EditorTareasState();
}

class _EditorTareasState extends State<EditorTareas> {
  Task Nota=new Task(
    Limpio: true,
    Dias: List.filled(7, false),
    Nombre: '',
    Descripcion: '',
    Done: false,
  );
  double betw=15;
  bool Cambio=false;
  List<bool> values=List.filled(7,false) ;
  List<bool> BotonTime= List.filled(2, false);
  List<bool> BotonMinutos= List.filled(4, false);
  String Horas="00",Minutos="00";
  TextEditingController ControlDesc= TextEditingController();
  TextEditingController ControlName= TextEditingController();
  String opcion;
  List<String> OpcionDias=['Solo hoy','Otros Dias'];
  int HoraTemp,MinuTemp;
  List<int> MinutosArr=[1,5,15,60];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(Nota.Limpio==true) {
      //isInstanceOf();
      dynamic cosa=ModalRoute.of(context).settings.arguments;
      //print( "da thin= ${cosa }");
      Nota.Nombre=cosa['Nombre'];
      Nota.Dias=cosa['Dias'];
      Nota.Descripcion=cosa['Descripcion'];
      Nota.Limpio=false;
      Nota.Tempo=cosa['Tempo'];
      Nota.Hora=cosa[ 'Hora' ];
      Nota.Minu=cosa['Minu'];
      Nota.Today=cosa['Today'];
      ///print("H=${Nota.Hora} ___ M=${Nota.Minu}");
      setState(() {
        ControlDesc=TextEditingController( text: Nota.Descripcion );
        ControlName=TextEditingController( text: Nota.Nombre );
        //Horas=cosa['Hora'];
        //Minutos=cosa['Minu'];
        //values=Nota.Dias;
        for(int i=0;i<7;i++) {
          values[i]=Nota.Dias[i];
          //print(" val $i = ${values[i]} ");
        }
        if( Nota.Tempo==true )
          BotonTime[1]=true;
        else
          BotonTime[0]=true;
        if( Nota.Today==true )
          opcion=OpcionDias[0];
        else
          opcion=OpcionDias[1];
        //print("===- $opcion");
      });
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(150,150,150, 1),
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        title: Text(
          "Editor de tareas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            letterSpacing: 1,
            //fontFamily: 'EastSeaDokdo-Regular',
            //fontFamily: 'Bellota-BoldItalic',
            fontFamily: 'Peddana-Regular',

          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
          onPressed: (){
            if( Cambio==true )
              showDialog(
                context: context,
                builder: (context)=> AlertDialog(
                  content: Text(
                    'Deseas salir sin guardar los cambios?',
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
            else
              Navigator.pop(context,null );
          },
        ),
       /* actions: <Widget>[
          Builder(
            builder: (context)=>
                Padding(
                  padding: const EdgeInsets.only(right:  20),
                  child: GestureDetector(
                    ///backgroundColor: Colors.green,
                    child: Icon(
                      Icons.save,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: (){
                      if(Nota.Nombre.isNotEmpty)
                        Navigator.pop(context, {
                          'Nombre': Nota.Nombre,
                          'Descripcion': Nota.Descripcion,
                          'Dias': Nota.Dias,
                          'Tempo': Nota.Tempo,
                        });
                      else {
                        //print("ya jalaa");
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Escribe el nombre de la nueva tarea'
                            ),
                          ),
                        );
                      }
                    },

                  ),
                ),
          ),
        ],*/
      ),
      body: Builder(
        builder: (context)=>  Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(7),
            child: ListView(
              children: <Widget>[
                TextField(
                  controller: ControlName,
                  textAlign: TextAlign.center,
                  cursorWidth: 5,
                  decoration: InputDecoration(
                    /*enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide( color: Colors.red ),
                            borderRadius: BorderRadius.all( Radius.circular(30) )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide( color: Colors.green ),
                              borderRadius: BorderRadius.all( Radius.circular(30) )
                          ),*/
                    //border:  OutlineInputBorder(),
                      labelText: "Nombre",
                      //prefixIcon: Icon( Icons.title ),
                      //hintText: "Nombre de Tarea",
                      filled: true,
                      fillColor: Colors.white
                  ),
                  onChanged: (String text){
                    Cambio=true;
                    Nota.Nombre=text;
                  },
                  //autofocus: true,
                ),
                SizedBox( height: betw, width: betw, ),
                TextField(
                  controller: ControlDesc,
                  maxLines:4,
                  textInputAction: TextInputAction.done,
                  //cursorWidth: 5,
                  ///textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText:  "Descripción",
                      filled: true,
                      fillColor: Colors.white
                  ),
                  onChanged: (String text){
                    Cambio=true;
                    Nota.Descripcion=text;

                  },
                ),
                SizedBox( height: betw, width: betw, ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "¿que dias lo vas a hacer?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        //letterSpacing: 1,
                        fontFamily: 'Bellota-BoldItalic',
                      ),
                    ),
                    DropdownButton(
                       dropdownColor: Color.fromRGBO(150,150,150, 1),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        //letterSpacing: 1,
                        fontFamily: 'Bellota-BoldItalic',),
                      hint: Text(
                        "Dias",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          //letterSpacing: 1,
                          fontFamily: 'Bellota-BoldItalic',
                        ),
                      ),
                      value: opcion,
                      onChanged: (String newValue) {
                        setState(() {
                          opcion= newValue;
                          if( OpcionDias[1].compareTo( opcion )==0 )
                            Nota.Today=false;
                          else
                            Nota.Today=true;
                        });
                      },
                      items: OpcionDias.map((String location) {
                        return new DropdownMenuItem<String>(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList()
                    ),
                  ],
                ),
                if( OpcionDias[1].compareTo( opcion )==0 )
                  SizedBox( height: betw, width: betw, ),
                if( OpcionDias[1].compareTo( opcion )==0 )
                  Text(
                  "Selecciona otros dias",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    //letterSpacing: 1,
                    fontFamily: 'Bellota-BoldItalic',
                  ),
                ),
                if( OpcionDias[1].compareTo( opcion )==0 )
                  SizedBox( height: betw, width: betw, ),
                if( OpcionDias[1].compareTo( opcion )==0 )
                WeekdaySelector(
                  fillColor: Colors.white,
                  firstDayOfWeek: 1,
                  /// letra del color
                  color: Colors.black,
                  selectedFillColor: Colors.blue[700],

                  onChanged: (int day) {
                    setState(() {
                      Cambio=true;
                      // Use module % 7 as Sunday's index in the array is 0 and
                      // DateTime.sunday constant integer value is 7.
                      final index = day % 7;
                      // We "flip" the value in this example, but you may also
                      // perform validation, a DB write, an HTTP call or anything
                      // else before you actually flip the value,
                      // it's up to your app's needs.
                      values[index] = !values[index];

                      for (var i = 0; i < 7; ++i)
                        Nota.Dias[i]=values[i];
                    });
                  },
                  values: values,
                ),

                SizedBox( height: betw, width: betw, ),
                Text(
                  "¿Como quieres medir el tiempo?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    //letterSpacing: 1,
                    fontFamily: 'Bellota-BoldItalic',
                  ),
                ),
                SizedBox( height: betw, width: betw, ),

                Center(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: ToggleButtons(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Cronometro",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            //letterSpacing: 1,
                            fontFamily: 'Bellota-BoldItalic',
                          ),
                        ),
                        ///color: Colors.purple,
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                      Container(
                        child: Text(
                          "Temporizador",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            //letterSpacing: 1,
                            fontFamily: 'Bellota-BoldItalic',
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                    ],
                    isSelected: BotonTime,
                    onPressed: (int index){
                      setState(() {
                        if( BotonTime[index]==false ) {
                          Cambio=true;
                          for (int i = 0; i < 2; i++)
                            BotonTime[i] = !BotonTime[i];
                        }
                        Nota.Tempo=BotonTime[1];
                      });
                    },

                    fillColor: Colors.blue[700],
                  ),
                ),
                if( BotonTime[1]==true )
                  SizedBox( height: betw, width: betw, ),
                if( BotonTime[1]==true )
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Hora'),
                      SizedBox( width: 40, ),
                      Text('Minutos'),
                    ],
                  ),
                if( BotonTime[1]==true )
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${Nota.Hora}:${Nota.Minu}",
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                      Builder(
                        builder: (context) =>
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size:30,
                            color: Colors.red[700],
                          ),
                          onPressed: (){
                            setState(() async{
                              //.toString().padLeft(2, '0');
                              HoraTemp=int.parse(Nota.Hora);
                              MinuTemp=int.parse(Nota.Minu);
                              await showDialog(
                                context: context,
                                builder: (ontext){
                                  return StatefulBuilder(
                                    builder: (context,setState){
                                      return AlertDialog(
                                        content: Container(
                                          height: 200,
                                          width: 200,
                                          child: Column(
                                            //mainAxisAlignment: MainAxisAlignment.spaceA,
                                            children: <Widget>[
                                              Text(
                                                'Configura el Tiempo',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  //fontFamily: 'EastSeaDokdo-Regular',
                                                  fontFamily: 'Bellota-BoldItalic',
                                                  //fontFamily: 'Peddana-Regular',

                                                ),
                                              ),
                                              SizedBox(height: 20, width: 20,),
                                              Text(
                                                "${Nota.Hora}:${Nota.Minu}",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                ),
                                              ),
                                              SizedBox(height: 20, width: 20,),
                                              ToggleButtons(
                                                children: <Widget>[
                                                  Text(
                                                    "1m",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      //letterSpacing: 1,
                                                      fontFamily: 'Bellota-BoldItalic',
                                                    ),
                                                  ),
                                                  Text(
                                                    "5m",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      //letterSpacing: 1,
                                                      fontFamily: 'Bellota-BoldItalic',
                                                    ),
                                                  ),
                                                  Text(
                                                    "15m",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      //letterSpacing: 1,
                                                      fontFamily: 'Bellota-BoldItalic',
                                                    ),
                                                  ),
                                                  Text(
                                                    "60m",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      //letterSpacing: 1,
                                                      fontFamily: 'Bellota-BoldItalic',
                                                    ),
                                                  ),
                                                ],
                                                isSelected: BotonMinutos,
                                                onPressed: (int index){
                                                  setState(() {
                                                    //print(index);
                                                    MinuTemp+=MinutosArr[index];
                                                    if( MinuTemp>=60 ) {
                                                      HoraTemp++;
                                                      MinuTemp-=60;
                                                    }
                                                    Nota.Hora=(HoraTemp).toString().padLeft(2, '0');
                                                    Nota.Minu=(MinuTemp).toString().padLeft(2, '0');
                                                    //print(" ${Nota.Hora} ${Nota.Minu} ");

                                                  });
                                                },
                                                fillColor: Colors.blue[700],
                                              ),
                                              //SizedBox(height: 20, width: 20,),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "reset",
                                              style: TextStyle(
                                                fontSize: 20,
                                                //fontFamily: 'EastSeaDokdo-Regular',
                                                fontFamily: 'Bellota-BoldItalic',
                                                //fontFamily: 'Peddana-Regular',
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                HoraTemp=0; MinuTemp=0;
                                                Nota.Hora=(HoraTemp).toString().padLeft(2, '0');
                                                Nota.Minu=(MinuTemp).toString().padLeft(2, '0');
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              'Guardar',
                                              style: TextStyle(
                                                fontSize: 20,
                                                //fontFamily: 'EastSeaDokdo-Regular',
                                                fontFamily: 'Bellota-BoldItalic',
                                                //fontFamily: 'Peddana-Regular',
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                            onPressed: (){
                                              Navigator.pop(context,null );
                                              //Navigator.pop(context,null );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              );
                              Nota.Hora=(HoraTemp).toString().padLeft(2, '0');
                              Nota.Minu=(MinuTemp).toString().padLeft(2, '0');
                              //print(" ${Nota.Hora}===${Nota.Minu} ");
                              super.setState(() { });
                            }
                            );
                          },
                        ),
                      ),
                    ],
                  ),

              ],
            ),
          ),
        ),

      ),
      floatingActionButton: Builder(
        builder: (context)=>
            FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.save,
                size: 30,
                color: Colors.white,
              ),
              onPressed: (){
                if(Nota.Nombre.isNotEmpty)
                  Navigator.pop(context, {
                    'Nombre': Nota.Nombre,
                    'Descripcion': Nota.Descripcion,
                    'Dias': Nota.Dias,
                    'Tempo': Nota.Tempo,
                    'Today': Nota.Today,
                    'Hora':Nota.Hora,
                    'Minu':Nota.Minu,
                  });
                else {
                  //print("ya jalaa");
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Escribe el nombre de la nueva tarea'
                      ),
                    ),
                  );
                }
              },
            ),
      ),
    );
  }
}