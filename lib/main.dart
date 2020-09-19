import 'package:agendaprocrastinacion/EditorMetas.dart';
import 'package:agendaprocrastinacion/EditorTareas.dart';
import 'package:agendaprocrastinacion/Home.dart';
import 'package:agendaprocrastinacion/Loading.dart';
import 'package:agendaprocrastinacion/Resultado.dart';
import 'package:agendaprocrastinacion/Tiempo.dart';
import 'package:agendaprocrastinacion/TipList.dart';
import 'package:agendaprocrastinacion/EditorTareas.dart';
import 'package:flutter/material.dart';

void main() => runApp( MaterialApp(

  initialRoute: '/',
  routes:{
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/tiplist': (context) => TipList(),
    '/editor': (context) => EditorTareas(),
    '/tiempo': (context) => CountDownTimer(),
    '/resultado': (context) => Resultado(),
      '/editormeta':(context)=> EditorMetas(),
  }


));
