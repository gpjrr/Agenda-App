import 'dart:ffi';

class Meta{
  int Days;
  String Name;
  String Why;
  int StepN;
  List< String > StepD;
  Double Progress;
  Meta( {
    this.StepN,
    this.Days,
    this.Name,
    this.Why,
    this.StepD,
    this.Progress
  } );
}