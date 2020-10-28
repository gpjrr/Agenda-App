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

  Meta from(Map<String, dynamic> jsn){
    Meta mapota = new Meta(
    );
    return mapota;
  }


  Map<String, dynamic> toJson() {

    Map<String, dynamic> mapita= {

    };
//    print("\n mapita=$mapita \n");
    return mapita;
  }




}