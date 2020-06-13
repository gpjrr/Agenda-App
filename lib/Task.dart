import 'dart:html';

class Task {
  String Nombre;
  String Descripcion;
  bool Done;
  bool NuevaTarea=false;
  List Dias;
  //final dias=List.filled(7, false);
  Task( {this.Nombre,this.Descripcion,this.Done,this.Dias} );
}