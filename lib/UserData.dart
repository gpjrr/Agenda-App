class UserData{
  List<int> DailyTime =List.filled(400,0);
  String NombreU;
  int TaskCont;
  UserData( {
    this.DailyTime,
    this.NombreU,
    this.TaskCont,
  } );
  UserData from( Map<String,dynamic> jsn){
    UserData yo=new UserData(
      DailyTime: jsn['DailyTime'],
      NombreU: jsn['NombreU'],
      TaskCont: jsn['TaskCont'],
    );
    return yo;
  }
  Map<String, dynamic> toJson(){
    Map<String, dynamic> mapita= {
      'DailyTime':DailyTime,
      'NombreU':NombreU,
      'TaskCont':TaskCont,
    };
    return mapita;
  }

}