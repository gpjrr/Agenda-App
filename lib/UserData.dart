import 'package:jiffy/jiffy.dart';

class UserData{
  List<int> DailyTime;
  String NombreU;
  int TaskCont;
  List<int> WeekDay= List.filled(7,0);
  ////List<int>
  UserData( {
    this.DailyTime,
    this.NombreU,
    this.TaskCont,
  } );
  UserData from( Map<String,dynamic> jsn){
    UserData yo=new UserData(
     // DailyTime: jsn['DailyTime'],
      NombreU: jsn['NombreU'],
      TaskCont: jsn['TaskCont'],
    );
    yo.DailyTime=new List.filled(400, 0);
    var tem = jsn['DailyTime'];
    for(int i=0;i<400;i++)
      yo.DailyTime[i]=tem[i] ;
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

  void DaysWeek(){
    if( DailyTime==null )
        DailyTime=new List.filled(500, 0);
        

    List<bool> Dias = List.filled(7, false);
    var now = DateTime.now();
    int dis;
    var date = DateTime(now.year, now.month, now.day);
    var UltimoDiaMes = DateTime(now.year, now.month + 1, 0);
    var lastMonday = date.subtract(Duration(days: date.weekday - 1)).day;
    dis = date.day - lastMonday;

    if (date.day >= lastMonday)
      WeekDay[ (1 + dis) % 7 ]=Jiffy().dayOfYear;
    else {
      dis = UltimoDiaMes.day - lastMonday;
      dis += (date.day - 1);
      WeekDay[ (1 + dis) % 7 ] =Jiffy().dayOfYear;
    }

    for(int i=1;i<7;i++)
        if( WeekDay[i-1]>0 && WeekDay[i]==0 )
          WeekDay[i]=WeekDay[i-1]+1;

    for(int i=5;i>=0;i--) {
      if (WeekDay[i + 1] > 0 && WeekDay[i] == 0) {
        WeekDay[i] = WeekDay[i + 1] - 1;
      }
    }

    List<int>Temp=new List.filled(7,0);
    for(int i=0;i<7;i++)
      Temp[i]=WeekDay[i]+1;
    print('Temp=== $Temp');
    ///print('week=== $WeekDay');
    for(int i=1;i<=7;i++){
      //print('i=$i, ${i%7}  ${i-1}');
      //print('i=$i, --- ${ WeekDay[i%7] }  ${ Temp[i-1] }');
      WeekDay[i%7]=Temp[i-1];
      //print('i=$i, --- ${ WeekDay[i%7] }  ${ Temp[i-1] }');
    }
    print('week=== $WeekDay');

    //print(date.day);
    //print(lastMonday);
    //print( (1+dis)%7 );
  }

}