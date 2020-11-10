import 'package:flutter/material.dart';

class FirstView extends StatefulWidget {
  @override
  _FirstViewState createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  String Nombre;
  TextEditingController ControlName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue[700],
      body: Builder(
        builder: (context)=> Container(
          padding:  EdgeInsets.fromLTRB(10, 40, 10, 10),
          child: ListView(
            children: <Widget>[
              Center(
                heightFactor: 1,
                widthFactor: 1,
                child: Text(
                  'cual es tu nombre?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    letterSpacing: 1,
                    //fontFamily: 'Bellota-BoldItalic',
                    fontFamily: 'Caveat-Regular',
                  ),
                ),
              ),
              SizedBox(height: 40,width: 40,),
              TextField(
                textInputAction: TextInputAction.done,
                controller: ControlName,
                textAlign: TextAlign.center,
                cursorWidth: 7  ,
                cursorHeight: 25,
                maxLines: 1,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide( color: Colors.black ),
                        borderRadius: BorderRadius.all( Radius.circular(10) )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide( color: Colors.white ),
                        borderRadius: BorderRadius.all( Radius.circular(10) )
                    ),
                    border:  OutlineInputBorder(),
                    labelText: "Nombre",
                    ///prefixIcon: Icon( Icons.title ),
                    //hintText: "Nombre de Tarea",
                    filled: true,
                    fillColor: Colors.white
                ),
                onChanged: (String text){
                  Nombre=text;
                  ///print('${logro.Name}\n');
                },
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,

                ),
                //autofocus: true,
              ),
              FlatButton(
                color: Colors.green,
                child: Text(
                  'Guardar',
                  style: TextStyle(
                    fontSize: 20,
                    //fontFamily: 'EastSeaDokdo-Regular',
                    fontFamily: 'Bellota-BoldItalic',
                    //fontFamily: 'Peddana-Regular',
                  ),
                ),
                onPressed: (){
                  Navigator.pop(context, {
                    'Nombre': Nombre,
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
