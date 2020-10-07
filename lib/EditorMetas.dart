import 'package:agendaprocrastinacion/Meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditorMetas extends StatefulWidget {
  @override
  _EditorMetasState createState() => _EditorMetasState();
}

class _EditorMetasState extends State<EditorMetas> {
  double ld=0;
  Meta logro=new Meta(
    Days:0,
    Why:'',
    StepD: new List(10),
    StepN: 0,
    Name: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.yellow,
            body: Builder(
              builder: (context)=> Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding:  EdgeInsets.all(7),
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'Nombre de la meta',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 50,
                            letterSpacing: 1,
                          //fontFamily: 'Bellota-BoldItalic',
                          fontFamily: 'Caveat-Regular',
                        ),
                      ),

                    ],
                  ),
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
