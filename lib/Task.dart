import 'dart:html';

class Task {
  String Nombre;
  String Descripcion;
  bool Done;
  /// por checar
  final dias=List.filled(7, false);
  Task( {this.Nombre,this.Descripcion,this.Done} );
}