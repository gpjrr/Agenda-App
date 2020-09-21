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
            appBar: AppBar(
              title: Text('sdfsdf'),
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
