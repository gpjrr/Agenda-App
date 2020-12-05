//import 'dart:html';
//import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';

class Task {
  List<int> WDay;

  bool Today; /// para saber si la tarea solo es para hoy
  ///int year=Jiffy().dayOfYear;
  int ID;
  String Hora, Minu;
  Key Lave;
  String Nombre;
  String Descripcion;
  bool Tempo;
  bool Done;
  bool Limpio;
  List<bool> Dias;
  List<int> Crayola;
  Icon Reloj;

  Task({ this.Nombre, this.Descripcion, this.Done, this.Dias,
    this.Lave, this.Limpio, this.Tempo, this.Hora, this.Minu,
    this.Today, this.ID,  this.WDay,  this.Reloj,this.Crayola
  });

  void Hoy() {
//    print('ano= $YearDay ');

    this.Dias = List.filled(7, false);
    var now = DateTime.now();
    int dis;
    var date = DateTime(now.year, now.month, now.day);
    var UltimoDiaMes = DateTime(now.year, now.month + 1, 0);
    var lastMonday = date.subtract(Duration(days: date.weekday - 1)).day;
    dis = date.day - lastMonday;

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
    // print("convierte json\n");
    Task mapota = new Task(
       Nombre: jsn['Nombre'],
       Descripcion: jsn['Descripcion'],
       Done: jsn['Done'],
       //Lave=json['Lave'],
       Limpio: jsn['Limpio'],
       Tempo: jsn['Tempo'],
       Hora: jsn['Hora'],
       Minu: jsn['Minu'],
       Today: jsn['Today'],
       ID:jsn['ID'],
      // WDay: jsn['WDay'],
     );
       // print("convierte los arreglos \n");
        mapota.Dias = new List.filled(7, false);
        var tem = jsn['Dias'];
        for (int i = 0; i < 7; i++)
          mapota.Dias[i] = (tem[i]);
        //print('NOMBRE=${mapota.Nombre} MP=${mapota.Dias}\n');
        //print("convierte los arreglos part2\n");
        // print("jsn en Task===  ${ jsn['WDay'] }");
        mapota.WDay=new List.filled(400, 0);
        var tem2 = jsn['WDay'];
        for(int i=0;i<400;i++)
          mapota.WDay[i]=(tem2[i]);
        //print('NOMBRE=${mapota.Nombre} MP=${mapota.WDay}\n');
        return mapota;
  }

  Map<String, dynamic> toJson() {
   // Map<String ,dynamic> MDias={};
    /*for(int i=0;i<7;i++)
      MDias['i']=Dias[i];*/
    print(" arreglo = ${ this.WDay } ");
    Map<String, dynamic> mapita= {
      'Nombre': Nombre,
      'Descripcion': Descripcion,
      'Done': Done,
      'Dias': Dias,
      //'Lave': Lave,
      'Limpio': Limpio,
      'Tempo': Tempo,
      'Hora': Hora,
      'Minu': Minu,
      'Today': Today,
      'ID': ID,
      'WDay': WDay,
    };
   ///print("\n mapita=${mapita['Wday'] } \n");
    return mapita;
    }


}