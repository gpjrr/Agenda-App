import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {
  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado > {
  int Minutos;
  bool ban=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(const Duration(seconds : 5));
  }
  @override
  Widget build(BuildContext context) {
    if( ban==false ){
      Minutos=ModalRoute.of(context).settings.arguments;
      ban=true;
    }
    return Scaffold(
        //backgroundColor: Color.fromRGBO(238, 232, 2, 1),
      backgroundColor: Colors.yellow[500],
        body: Builder(
          builder: (context)=> Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(
                    height: 40,
                    //width: 30,
                  ),
                  Text(
                    /// explicamos el tiempo en horas con decimal
                    'Te haz concentrado durante ${Minutos} minutos',
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 1,
                      color: Colors.black,
                      fontFamily: 'Bellota-BoldItalic',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                    //width: 30,
                  ),
                  FlatButton.icon(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)
                      ),
                      label: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1,
                          color: Colors.black,
                          fontFamily: 'Bellota-BoldItalic',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      color: Colors.blue[600],
                      icon: Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 50,

                      )
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
