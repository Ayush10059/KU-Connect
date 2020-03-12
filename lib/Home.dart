import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import 'package:ku/Storage.dart';
import 'package:ku/Routine.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


DateTime now = new DateTime.now();

var day = DateFormat.d().format(now);
var weekDay = DateFormat.EEEE().format(now);
var date = DateFormat.yMMMd().format(now);
var time = DateFormat.jm().format(now);

var min = time.toString().split(":")[1].split(" ")[0];
var periods = time.toString().split(":")[1].split(" ")[1];

class _HomeState extends State<Home> {

List<Future<List<Record>>> _uFuture = [];

  @override
  void initState() {
    super.initState();

    _uFuture.add(getOngoingData());
    _uFuture.add(getUpcomingData());
    _uFuture.add(getPrevData());
  }
  
  Future <List <Record>> getUpcomingData() async {
    Storage routinedata = new Storage("routine.json");
    String rData = await routinedata.readData();
    var rDataMap =  jsonDecode(rData);
    List <Record> today = [];
    List <String> week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    for (var rec in rDataMap) {
      if ((week.indexOf(weekDay) + 1) == rec["weekDay"]) {
        var hour = int.parse(time.toString().split(":")[0]);
        if (periods == "PM")
          hour += 12;   
        var timeNow = int.parse(hour.toString() + "" + min);
        var timeRecStart = rec["startTime"].toString().split(":").join();
        if (timeNow < int.parse(timeRecStart)) {
          today.add(Record(rec["weekDay"], rec["subject"], rec["sCode"], rec["lecturer"], rec["classroom"], rec["facSem"], rec["startTime"], rec["endTime"]));
        }
      }
    }
    return today;
  }

  Future <List <Record>> getPrevData() async {
    Storage routinedata = new Storage("routine.json");
    String rData = await routinedata.readData();
    var rDataMap =  jsonDecode(rData);
    List <Record> today = [];
    List <String> week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    
    for (var rec in rDataMap) {
      if ((week.indexOf(weekDay) + 1) == rec["weekDay"]) {
        var hour = int.parse(time.toString().split(":")[0]);
        if (periods == "PM")
          hour += 12;      
        var timeNow = int.parse(hour.toString() + "" + min);
        var timeRecEnd = rec["endTime"].toString().split(":").join();
        if (timeNow > int.parse(timeRecEnd)) {
          today.add(Record(rec["weekDay"], rec["subject"], rec["sCode"], rec["lecturer"], rec["classroom"], rec["facSem"], rec["startTime"], rec["endTime"]));
        }
      }
    }
    // for (var t in today)
    //   print(t.sCode);
    return today;
  }
  
  
  Future <List <Record>> getOngoingData() async {
    Storage routinedata = new Storage("routine.json");
    String rData = await routinedata.readData();
    var rDataMap =  jsonDecode(rData);
    List <Record> today = [];
    List <String> week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    for (var rec in rDataMap) {
      if ((week.indexOf(weekDay) + 1) == rec["weekDay"]) {
        var hour = int.parse(time.toString().split(":")[0]);
        if (periods == "PM")
          hour += 12;
        var timeNow = int.parse(hour.toString() + "" + min);
        var timeRecStart = rec["startTime"].toString().split(":").join();
        var timeRecEnd = rec["endTime"].toString().split(":").join();
        print(" ");
        if (int.parse(timeRecStart) <= timeNow && timeNow <= int.parse(timeRecEnd)) {
          today.add(Record(rec["weekDay"], rec["subject"], rec["sCode"], rec["lecturer"], rec["classroom"], rec["facSem"], rec["startTime"], rec["endTime"]));
        }
      }
    }
    return today;
  }

  // Future<void> selectNotification(String payload) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => new AlertDialog(
  //       title: Text("KU-Connect"),
  //       content: Text(payload),
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("KU-Connect", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          leading: Image.asset('assets/KU.png'),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),  
                child: Column(
                  children: <Widget> [
                    Text(weekDay, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),),
                    Text(date, style: TextStyle(fontSize: 20.0, color: Colors.black54),),
                  ]
                )
            ),

            FlutterAnalogClock(
              dateTime: DateTime.now(),
              dialPlateColor: Colors.grey[200],
              hourHandColor: Colors.black,
              minuteHandColor: Colors.black,
              secondHandColor: Colors.black54,
              numberColor: Colors.black,
              borderColor: Colors.black,
              tickColor: Colors.redAccent[200],
              centerPointColor: Colors.black45,
              showBorder: true,
              showTicks: true,
              showMinuteHand: true,
              showSecondHand: true,
              showNumber: true,
              borderWidth: 0.0,
              hourNumberScale: 1.0,
              hourNumbers: ['', '', '', '', '', '', '', '', '', '', '', ''],
              isLive: true,
              width: 150.0,
              height: 150.0,
              decoration: const BoxDecoration(),
            ),

            Padding(
              padding: const EdgeInsets.all( 20.0),
              child: DigitalClock(
                digitAnimationStyle: Curves.elasticOut,
                is24HourTimeFormat: false,
                areaDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                hourMinuteDigitDecoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent)
                ),
                secondDigitDecoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent)
                ),
                hourMinuteDigitTextStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 50,
                ),
                amPmDigitTextStyle: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 8.0),
              child: Text("Ongoing Class: ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            ),

            FutureBuilder(
              future: _uFuture[0],
              builder: (BuildContext context, AsyncSnapshot <List <Record>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container();

                else
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {                  
                      return Card(
                        child: ListTile(
                        title: Text(snapshot.data[index].subject),
                        subtitle: Text(snapshot.data[index].startTime + " - " + snapshot.data[index].endTime),
                        onTap: () {
                          if (snapshot.data[0].lecturer != "0")
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Routine(snapshot.data[index]))
                          );
                        }
                      ),
                    );
                  }
                );
              }
            ),

            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0),
              child: Text("Upcoming Class(es): ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            ),

            FutureBuilder(
              future: _uFuture[1],
              builder: (BuildContext context, AsyncSnapshot <List <Record>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container();

                else
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {                  
                      return Card(
                        child: ListTile(
                        title: Text(snapshot.data[index].subject),
                        subtitle: Text(snapshot.data[index].startTime + " - " + snapshot.data[index].endTime),
                        onTap: () {
                          if (snapshot.data[0].lecturer != "0")
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Routine(snapshot.data[index]))
                          );
                        }
                      ),
                    );
                  }
                );
              }
            )
          ],
        ),
      ),
    );
  }

  

}

class Record {
  final int weekDay;
  final String subject;
  final String sCode;
  final String lecturer;
  final String classroom;
  final String facSem;
  final String startTime;
  final String endTime;

  Record(this.weekDay, this.subject, this.sCode, this.lecturer, this.classroom, this.facSem, this.startTime, this.endTime);
}