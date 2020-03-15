import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart';

import 'package:ku/Storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class _LoadState extends State<Load> with AutomaticKeepAliveClientMixin {

  String errorRegister = "";
  Map<String, dynamic> token;

@override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      var android = new AndroidInitializationSettings('@drawable/ku');
      var ios = new IOSInitializationSettings();
      var initSetttings = new InitializationSettings(android,ios);
      flutterLocalNotificationsPlugin.initialize(initSetttings);
    doEveryThing().then((dynamic d) {
      Navigator.pushReplacementNamed(context, "/app");
    });
  }
  Future doEveryThing () async {
    Storage userData = new Storage("user.json");
    String uData = await userData.readData();
    Map<String, dynamic> uDataMap = jsonDecode(uData);
    token = uDataMap["token"];
    String exp = token["expiration"].toString();
    String tc = token["ticket"].toString();
    String bodyStr = '{ "token" : { "expiration" : $exp , "ticket" : "$tc"  } }';
    Response res = await post('http://34.227.26.246/api/data/get', headers: headers, body: bodyStr);

    Storage routinedata = new Storage("routine.json");
    await routinedata.writeData(res.body.toString());
    List rtData = jsonDecode(res.body);
    int count = 0;
    for (var t in rtData) {
      Map<String, dynamic> rec = jsonDecode(t);
      await showNotification(count, rec["subject"], rec["startTime"], rec["weekDay"], rec["classroom"]);
      count++;
    }
  }

  Future<void> showNotification(int id, String sub, String st, String dy, String cls) async {
    var android = new AndroidNotificationDetails(
        'id', 'NAME', 'DESCRIPTION',
        priority: Priority.High,
        importance: Importance.Max,
        enableVibration: true
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    print("Notification set: $id $sub $st $cls");
    var week = [Day.Sunday, Day.Monday, Day.Tuesday, Day.Wednesday, Day.Thursday, Day.Friday, Day.Saturday];
    print(week[int.parse(dy) - 1]);
    var hour = int.parse(st.split(":")[0]) - 1;
    if (hour == 0)
      hour = 12;
    print(hour);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id,
        '$sub',
        'You have class at $st in block/class $cls',
        week[int.parse(dy) - 1],
        Time(hour, 45, 0),
        platform,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[300],
        child: Center(
          child: SpinKitChasingDots(
          color: Colors.blueGrey[500],
          size: 50.0,
          ),
        ),
      )
    );
  }
}