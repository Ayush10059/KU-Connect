import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

DateTime now = new DateTime.now();

var day = DateFormat.EEEE().format(now);
var date = DateFormat.yMMMd().format(now);
var time = DateFormat.jm().format(now);

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
              child: Column(
                children: <Widget>[
                  Text(day, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  Text(date, style: TextStyle(fontSize: 14.0, color: Colors.black54),),
                ],
              ),
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
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Card(
                color: Colors.grey[200],
                elevation: 0.0,
                child: ListTile(
                  onTap: () {},
//                  title: Text(token.toString()),
//                  subtitle: Text(dataFromFile),
                  ),
                ),
              ),
          ],
      ),
    );
  }
}