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

var weekDay = DateFormat.d().format(now);
var day = DateFormat.EEEE().format(now);
var date = DateFormat.yMMMd().format(now);
var time = DateFormat.jm().format(now);

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{

Future<List<Record>> _uFuture;

  @override
  void initState() {
    super.initState();

    _uFuture = getData();
  }

  Future <List <Record>> getData() async {
    Storage routinedata = new Storage("routine.json");
    String rData = await routinedata.readData();
    var rDataMap =  jsonDecode(rData);
    List <Record> today = [];
    for (var rec in rDataMap) {
      if (5 == rec["weekDay"]) {
        today.add(Record(rec["weekDay"], rec["subject"], rec["sCode"], rec["lecturer"], rec["classroom"], rec["facSem"], rec["startTime"], rec["endTime"]));
      }
    }

    if (today.length == 0)
    {
      today.add(Record(1, "No Class today", "0", "0", "0", "0", "Sunrise", "Sunset"));
    }

    return today;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    Text(day, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),),
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

            FutureBuilder(
              future: _uFuture,
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
  
  @override
  bool get wantKeepAlive => true;
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