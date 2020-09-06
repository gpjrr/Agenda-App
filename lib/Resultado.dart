import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {
  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado > {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(const Duration(seconds : 5));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromRGBO(238, 232, 2, 1),
      backgroundColor: Colors.yellow[500],
        body: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Text(
                  /// explicamos el tiempo en horas con decimal
                  'Te haz concentrado durante ',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1,
                    color: Colors.black,
                    fontFamily: 'Bellota-BoldItalic',
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
