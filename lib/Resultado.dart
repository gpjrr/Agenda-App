import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {
  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(238, 232, 2, 1),
        body: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Text(
                  '¡Felicidades!',
                  style: TextStyle(
                    fontSize: 50,
                    letterSpacing: 1,
                    color: Colors.black,
                      fontFamily: 'Unkempt-Bold',
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
