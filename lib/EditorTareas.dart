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
  double caja=200;
  bool Cambio=false;
  List<bool> values=List.filled(7,false) ;
  List<bool> BotonTime= List.filled(2, false);
  String Horas="00",Minutos="00";
  TextEditingController ControlHora= TextEditingController();
  TextEditingController ControlMinu= TextEditingController();
  TextEditingController ControlDesc= TextEditingController();
  TextEditingController ControlName= TextEditingController();
  TextEditingController ControlTime= TextEditingController();

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
      setState(() {
        ControlDesc=TextEditingController( text: Nota.Descripcion );
        ControlName=TextEditingController( text: Nota.Nombre );
        ControlHora=TextEditingController( text: Nota.Hora );
        ControlMinu=TextEditingController( text: Nota.Minu );
        ControlHora.selection = TextSelection.fromPosition(TextPosition(offset: ControlHora.text.length));
        ControlMinu.selection = TextSelection.fromPosition(TextPosition(offset: ControlMinu.text.length));
        Horas=cosa['Hora'];
        Minutos=cosa['Minu'];
        //values=Nota.Dias;
        for(int i=0;i<7;i++) {
          values[i]=Nota.Dias[i];
          //print(" val $i = ${values[i]} ");
        }
        //print("==${Nota.Tempo}");
        if( Nota.Tempo==true )
          BotonTime[1]=true;
        else
          BotonTime[0]=true;
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
          ),
          body:
            Builder(
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
                      SizedBox( height: 20, width: 20, ),
                      TextField(
                        controller: ControlDesc,
                        maxLines:4,
                        cursorWidth: 5,
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
                      SizedBox( height: 20, width: 20, ),
                      Text(
                        "¿que dias lo vas a hacer?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          //letterSpacing: 1,
                          fontFamily: 'Bellota-BoldItalic',
                        ),
                      ),
                      SizedBox( height: 20, width: 20, ),
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
                      SizedBox( height: 20, width: 20, ),
                      Text(
                        "¿Como quieres medir el tiempo?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          //letterSpacing: 1,
                          fontFamily: 'Bellota-BoldItalic',
                        ),
                      ),
                      SizedBox( height: 20, width: 20, ),

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
                        SizedBox( height: 10, width: 10, ),
                      if( BotonTime[1]==true )
                        Text('Hora'),
                      if( BotonTime[1]==true )
                        Container(
                          padding: EdgeInsets.fromLTRB(140, 0, 140, 0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: TextField(

                                  controller: ControlHora,
                                  textAlign: TextAlign.center,
                                  //cursorWidth: 5,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  maxLines: 1,

                                  onChanged: (String text){
                                    ControlHora.selection = TextSelection.fromPosition(TextPosition(offset: ControlHora.text.length));
                                    print(text);
                                    Cambio=true;
                                    Nota.Hora=text;

                                  },
                                  style: TextStyle(
                                    fontSize: 40
                                  ),
                                  //autofocus: true,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(":",
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: ControlHora,
                                  textAlign: TextAlign.center,
                                  //cursorWidth: 5,
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  maxLines: 1,

                                  onChanged: (String text){
                                    print(text);
                                    Cambio=true;
                                    Nota.Hora=text;
                                  },
                                  style: TextStyle(
                                      fontSize: 40
                                  ),
                                  //autofocus: true,
                                ),
                              ),
                            ],
                          ),
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
