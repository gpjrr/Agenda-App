import 'package:agendaprocrastinacion/EditorTareas.dart';
import 'package:agendaprocrastinacion/Home.dart';
import 'package:agendaprocrastinacion/Loading.dart';
import 'package:agendaprocrastinacion/TipList.dart';
import 'package:agendaprocrastinacion/EditorTareas.dart';
import 'package:flutter/material.dart';

void main() => runApp( MaterialApp(

  initialRoute: '/Loading',
  routes:{
    '/': (context)=> Loading(),
    '/home': (context)=> Home(),
    '/TipList':(context)=> TipList(),
    '/EditorTareas':(context)=> EditorTareas(),
  }


));
