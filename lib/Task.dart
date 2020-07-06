//import 'dart:html';
//import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Task {
  // agregar al constructor
  bool Today;
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
          this.Hora,
          this.Minu,
          this.Today,
  } );
  void Hoy(){
//// ano nuevo
    var now=DateTime.now();
    int dis;
    var date=DateTime(now.year,now.month,now.day);
    var UltimoDiaMes=DateTime(now.year,now.month+1,0);

    var lastMonday = date.subtract(Duration(days: date.weekday -1 )).day;
    dis = date.day - lastMonday;
    //print( "mes==$UltimoDiaMes" );
    //print(dis);
    if( date.day>=lastMonday ) {
      this.Dias[ (1 + dis) % 7 ] = true;
    }
    else{
      dis=UltimoDiaMes.day-lastMonday;
      dis+=(date.day-1);
      this.Dias[ (1 + dis) % 7 ] = true;
    }
    //print(date.day);
    //print(lastMonday);
    //print( (1+dis)%7 );
  }
}