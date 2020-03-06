import 'package:flutter/material.dart';
// import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import 'package:ku/Storage.dart';
import 'package:ku/Record.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Future uFuture;

DateTime now = new DateTime.now();

var day = DateFormat.EEEE().format(now);
var date = DateFormat.yMMMd().format(now);
var time = DateFormat.jm().format(now);

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    uFuture = getData();
  }

  getData() {
    Storage routinedata = new Storage("routine.json");
    routinedata.readData().then((String rData) {
      var rDataMap = jsonDecode(rData);
      print("data: $rDataMap");
      List <Record> today = [];
      for (var rec in rDataMap) {
        if (4 == rec["weekDay"])
          today.add(Record(rec["weekDay"], rec["time"], rec["subject"], rec["sCode"], rec["lecturer"], rec["classroom"], rec["facSem"]));
      }
      print(today);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Material(
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext, AsyncSnapshot snapshot) {
              return ListView( children: <Widget>[
                
                  Padding(
                    padding: const EdgeInsets.all(20.0),  
                    child: Column(
                      children: <Widget> [
                        Text(day, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                        Text(date, style: TextStyle(fontSize: 14.0, color: Colors.black54),),
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
                  // ListView.builder(
                  //   itemBuilder: (context, index) {
                  //     return Card(

                  //     )
                  //   }
                  //   )
              ],
            );
          }
        )
      )
    );
  }
}