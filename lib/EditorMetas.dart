import 'package:agendaprocrastinacion/Meta.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
