import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeekView {
  List<String> DaysC = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  List<int> valores;
  Map<int,Color> Fondo={
    0:Colors.white,
    -1:Colors.red,
    1: Colors.blue,
    2: Colors.yellowAccent,
    3: Colors.green,
  };
  Map<int,Color> Letra={
    0:Colors.black,
    -1:Colors.black,
    1:Colors.black,
    2:Colors.black,
  };

  WeekView({
    this.valores,
  });
  Container Semana() {

    List<Container> Circulos=new List();
    for (int i = 0; i < 7; i++) {
      Circulos.add(Container(
        width: 30.0,
        height: 30.0,
        decoration: new BoxDecoration(
          color: Fondo[ valores[i] ],
          shape: BoxShape.circle,
          border:   Border.all( width: 1, color: Colors.black),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            DaysC[i],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Letra[ valores[i] ],
              fontSize: 20,

            ),
          ),
        ),
      ));
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: Circulos,
      ),
    );
  }
}
