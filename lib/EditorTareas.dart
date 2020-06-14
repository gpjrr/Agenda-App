import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';
class EditorTareas extends StatefulWidget {
  @override
  _EditorTareasState createState() => _EditorTareasState();
}

class _EditorTareasState extends State<EditorTareas> {
  final values = List.filled(7, false);
  String TextoNombre;
  String TextoDescripcion;
  @override
  void initState() {
    var now=DateTime.now();
    int dis;
    var date=DateTime(now.year,now.month,now.day);
    var lastMonday = date.subtract(Duration(days: date.weekday -1 )).day;
    dis=date.day-lastMonday;
    //print( "hoy=$date.day" );
    //print( lastMonday );
    values[1+dis]=true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Color.fromRGBO(155,155,155, 1),
          appBar: AppBar(
            backgroundColor: Colors.yellow[500],
            centerTitle: true,
            title: Text(
              "Editor de tareas",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                letterSpacing: 1,
                fontFamily: 'Bellota-BoldItalic',
              ),
            ),
          ),
          body:
            Container(
              margin: EdgeInsets.all(30),
              width: 350,
              child: ListView(
                children: <Widget>[
                  TextField(
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
                       //labelText: "Nombre de tarea",
                      //prefixIcon: Icon( Icons.title ),
                      hintText: "Nombre de Tarea",
                      filled: true,
                      fillColor: Colors.white
                    ),
                    onChanged: (String text){
                      TextoNombre=text;
                    },
                    autofocus: true,
                  ),
                  SizedBox( height: 20, width: 20, ),
                  TextField(
                    maxLines:4,
                    cursorWidth: 5,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide( color: Colors.red ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide( color: Colors.green ),

                        ),
                        //prefixIcon: Icon( Icons.title ),
                        hintText: "Descripción",
                        filled: true,
                        fillColor: Colors.white
                    ),
                    onChanged: (String text){
                      TextoDescripcion=text;
                      //print("$TextoDescripcion $TextoNombre  ");
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
                    selectedFillColor: Colors.green,

                    onChanged: (int day) {
                      setState(() {
                        // Use module % 7 as Sunday's index in the array is 0 and
                        // DateTime.sunday constant integer value is 7.
                        final index = day % 7;
                        // We "flip" the value in this example, but you may also
                        // perform validation, a DB write, an HTTP call or anything
                        // else before you actually flip the value,
                        // it's up to your app's needs.
                        values[index] = !values[index];
                        for (var i = 0; i < 7; ++i) {
                          print("$i ${values[i]} ");

                        }

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
                  Row(
                    children: <Widget>[
                      
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
