import 'package:agendaprocrastinacion/Meta.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class EditorMetas extends StatefulWidget {
  @override
  _EditorMetasState createState() => _EditorMetasState();
}

class _EditorMetasState extends State<EditorMetas> {
  double ld = 0;
  bool inicio = false;
  Meta logro = new Meta(
    Days: 0,
    Why: '',
    StepD: new List(10),
    //StepN: 0,
    Name: '',
  );
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  TextEditingController ControlDias = TextEditingController();
  TextEditingController ControlNameG = TextEditingController();
  Widget seleccionador(){
    switch(_page) {
      case 0:
        return Scaffold(
        backgroundColor: Colors.blue[700],
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
                      color: Colors.white,
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
                          borderSide: BorderSide( color: Colors.black ),
                          borderRadius: BorderRadius.all( Radius.circular(10) )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide( color: Colors.white ),
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
                    ///print('${logro.Name}\n');
                  },
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,

                  ),
                  //autofocus: true,
                ),
                SizedBox(height: 40,width: 40,),
                Text(
                  'Busca ser concreto en el nombre para que lo recuerdes con facilidad',
                  style: TextStyle(
                    fontSize: 60,
                    height: 1,
                    color: Colors.white,
                    fontFamily: 'EastSeaDokdo-Regular',
                    //fontFamily: 'Bellota-BoldItalic',
                    //fontFamily: 'Peddana-Regular',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      case 1:
        return  Scaffold(
          backgroundColor: Colors.blue[700],
          body: Builder(
            builder: (context)=> Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: ListView(
                  //shrinkWrap: true,
                  children:[
                    Center(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Text(
                        '¿Cuantos dias necesitas?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 43,
                          letterSpacing: 1,
                          //fontFamily: 'Bellota-BoldItalic',
                          fontFamily: 'Caveat-Regular',
                        ),
                      ),
                    ),
                    SizedBox(height: 40,width: 40,),
                    Row(
                      ///crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextField(
                            controller: ControlDias,
                            onChanged: (String text){
                              logro.Days=int.parse( text );
                              //print(' ${logro.Days} ');
                            },
                            textInputAction: TextInputAction.done,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              //border:  OutlineInputBorder(),
                              //labelText: "Nombre",
                              ///prefixIcon: Icon( Icons.title ),
                              //hintText: "Nombre de Tarea",
                                filled: false,
                                fillColor: Colors.white
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50,
                              height: 1,
                              color: Colors.white,
                              fontFamily: 'EastSeaDokdo-Regular',
                              //fontFamily: 'Bellota-BoldItalic',
                              //fontFamily: 'Peddana-Regular',
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 8,
                          child: Text(
                            'Dias.',
                            style: TextStyle(
                              fontSize: 50,
                              height: 1,
                              color: Colors.white,
                              fontFamily: 'EastSeaDokdo-Regular',
                              //fontFamily: 'Bellota-BoldItalic',
                              //fontFamily: 'Peddana-Regular',
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40,width: 40,),
                    Text(
                      'define un plazo de tiempo, para ser concreto con tus metas',
                      style: TextStyle(
                        fontSize: 60,
                        height: 1,
                        color: Colors.white,
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
        );
      case 2:
        return Scaffold(
          backgroundColor: Colors.blue[700],
          appBar: AppBar(
            centerTitle: true,
            title:Text(
              'Componentes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            backgroundColor: Colors.red[400],
          ),
          body: Builder(
            builder: (context)=>Container(
              padding:  EdgeInsets.fromLTRB(10, 40, 10, 10),

            ),
          ),
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    if (inicio == false) {
      /// cargamos la informacion de la meta
      dynamic cosa = ModalRoute.of(context).settings.arguments;
      logro.Name = cosa['Name'];
      logro.Days = cosa['Days'];
      logro.StepD = cosa['StepD'];
      setState(() {
        ControlNameG.text = logro.Name;
        print('los dias son ${logro.Days}');
        ControlDias.text = logro.Days.toString();
        //ControlDias.text = '12';
        inicio = true;
      });
    }
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        //color: Colors.blue[700],
        backgroundColor: Colors.blue[700],
      ),
      body: seleccionador(),
    );
  }
}
