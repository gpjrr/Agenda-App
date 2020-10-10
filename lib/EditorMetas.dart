import 'package:agendaprocrastinacion/Meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class EditorMetas extends StatefulWidget {
  @override
  _EditorMetasState createState() => _EditorMetasState();
}

class _EditorMetasState extends State<EditorMetas> {
  double ld=0;
  bool inicio=false;
  Meta logro=new Meta(
    Days:0,
    Why:'',
    StepD: new List(10),
    StepN: 0,
    Name: '',
  );
  TextEditingController ControlNameG= TextEditingController();
  @override
  Widget build(BuildContext context) {
    if( inicio==false ){
      /// cargamos la informacion de la meta
      ControlNameG.text='adsf';
      inicio=true;
    }
    return Scaffold(
      backgroundColor: Colors.red,
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.yellow,
            body: Builder(
              builder: (context)=> Container(
                padding:  EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: ListView(
                  children: <Widget>[
                    Center(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Text(
                        'Nombre de la meta',
                        style: TextStyle(
                          color: Colors.purple[600],
                          fontSize: 50,
                            letterSpacing: 1,
                          //fontFamily: 'Bellota-BoldItalic',
                          fontFamily: 'Caveat-Regular',
                        ),
                      ),
                    ),
                    SizedBox(height: 40,width: 40,),
                    TextField(
                      textInputAction: TextInputAction.done,
                      controller: ControlNameG,
                      textAlign: TextAlign.center,
                      cursorWidth: 7  ,
                      cursorHeight: 25,
                      maxLines: 1,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide( color: Colors.red ),
                            borderRadius: BorderRadius.all( Radius.circular(10) )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide( color: Colors.green ),
                              borderRadius: BorderRadius.all( Radius.circular(10) )
                          ),
                        border:  OutlineInputBorder(),
                          labelText: "Nombre",
                          ///prefixIcon: Icon( Icons.title ),
                          //hintText: "Nombre de Tarea",
                          filled: true,
                          fillColor: Colors.white
                      ),
                      onChanged: (String text){
                        logro.Name=text;
                        print('${logro.Name}\n');
                        },
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,

                      ),
                      //autofocus: true,
                    ),
                    SizedBox(height: 40,width: 40,),
                    Text(
                      'Busca ser concreto en el nombre para que lo recuerdes con facilidad',
                       style: TextStyle(
                         fontSize: 60,
                         height: 1,
                         color: Colors.grey[600],
                         fontFamily: 'EastSeaDokdo-Regular',
                         //fontFamily: 'Bellota-BoldItalic',
                         //fontFamily: 'Peddana-Regular',
                       ),
                    ),


                  ],
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              title: Text('prueba2'),
            ),
          ),

        ],
      ),
    );
  }
}
