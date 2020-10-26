//import 'dart:html';
//import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
//part 'task.g.dart';

//@JsonSerializable()

class Task {
  // agregar al constructor
  bool Today;
  String Hora, Minu;
  Key Lave;
  String Nombre;
  String Descripcion;
  bool Tempo;
  bool Done;
  bool Limpio;
  List<bool> Dias;
  Icon Reloj;

  //Icon Reloj;
  //final dias=List.filled(7, false);
  Task({ this.Nombre, this.Descripcion,
    this.Done, this.Dias,
    this.Lave, this.Limpio,
    this.Tempo, this.Hora,
    this.Minu, this.Today,
  });

  void Hoy() {
///// ano nuevo
    this.Dias = List.filled(7, false);
    var now = DateTime.now();
    int dis;
    var date = DateTime(now.year, now.month, now.day);
    var UltimoDiaMes = DateTime(now.year, now.month + 1, 0);

    var lastMonday = date
        .subtract(Duration(days: date.weekday - 1))
        .day;
    dis = date.day - lastMonday;
    //print( "mes==$UltimoDiaMes" );
    //print(dis);
    if (date.day >= lastMonday) {
      this.Dias[ (1 + dis) % 7 ] = true;
    }
    else {
      dis = UltimoDiaMes.day - lastMonday;
      dis += (date.day - 1);
      this.Dias[ (1 + dis) % 7 ] = true;
    }
    //print(date.day);
    //print(lastMonday);
    //print( (1+dis)%7 );
  }

  void RelojIcono() {
    if (this.Tempo == true)
      this.Reloj = Icon(
        Icons.timelapse,
        size: 40,
        color: Colors.black,
      );
    else
      this.Reloj = Icon(
        Icons.timer,
        size: 40,
        color: Colors.black,
      );
  }

   Task from(Map<String, dynamic> jsn){
     Task mapota = new Task(
       Nombre: jsn['Nombre'],
       Descripcion: jsn['Descripcion'],
       Done: jsn['Done'],
       //  Dias: json['Dias'],
       // Lave=json['Lave'],
       Limpio: jsn['Limpio'],
       Tempo: jsn['Tempo'],
       Hora: jsn['Hora'],
       Minu: jsn['Minu'],
       Today: jsn['Today'],
     );
        mapota.Dias = new List.filled(7, false);
        var tem = jsn['Dias'];
        for (int i = 0; i < 7; i++)
          mapota.Dias[i] = (tem[i]);
        print('MP=${mapota.Dias}\n');
     return mapota;
  }


  Map<String, dynamic> toJson() {
    Map<String ,dynamic> MDias={};
    for(int i=0;i<7;i++)
      MDias['i']=Dias[i];
    Map<String, dynamic> mapita= {
      'Nombre': Nombre,
      'Descripcion': Descripcion,
      'Done': Done,
      'Dias': Dias,
     // 'Lave': Lave,
      'Limpio': Limpio,
      'Tempo': Tempo,
      'Hora': Hora,
      'Minu': Minu,
      'Today': Today,
    };
//    print("\n mapita=$mapita \n");
    return mapita;
    }

/* factory Task.fromJson( Map<String,dynamic> json )=> _$TaskFromJson(json);
  Map<String,dynamic> toJson()=>_$TaskToJson(this);
*/
}