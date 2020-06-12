import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    //// aqui vamos a descargar la informacion
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'lista de tareas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            letterSpacing: 1,
            fontFamily: 'Bellota-BoldItalic',
          ),
        ),
        backgroundColor: Colors.red,
      ),

      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon( Icons.people ),
              title: Text('hola'),
              trailing: Icon( Icons.beenhere ),
            ),
            ListTile(
              leading: Icon( Icons.people ),
              title: Text('popos'),
              trailing: Icon( Icons.beenhere ),
            ),
          ],

        ),
        

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {

          });
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          color: Colors.black87,

        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Tips'),
              trailing: Icon(
                Icons.lightbulb_outline,
                color: Colors.yellow,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Records'),
              trailing: Icon(
                Icons.book,
                color: Colors.brown,
              ),
              onTap: (){
                Navigator.pushNamed(context, '/TipList'  );
              },
            ),
          ],
        ),
      ),
    );


  }
}
