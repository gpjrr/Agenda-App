//import 'dart:html';
//import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Task {
  // agregar al constructor

  String Hora,Minu;
  Key Lave;
  String Nombre;
  String Descripcion;
  bool Tempo;
  bool Done;
  bool Limpio;
  List Dias;
  //final dias=List.filled(7, false);
  Task( { this.Nombre,
          this.Descripcion,
          this.Done,
          this.Dias,
          this.Lave,
          this.Limpio,
          this.Tempo,
  } );
  void Hoy(){
    var now=DateTime.now();
    int dis;
    var date=DateTime(now.year,now.month,now.day);
    var lastMonday = date.subtract(Duration(days: date.weekday -1 )).day;
    dis=date.day-lastMonday;
    this.Dias[ (1+dis)%7 ]=true;
  }
}