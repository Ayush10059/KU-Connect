import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart';

import 'package:ku/Storage.dart';

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String errorRegister = "";
  Map<String, dynamic> token;
  String startTime = '';
  String subject = '';
  String room = '';

@override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@drawable/ku');
    var ios = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android,ios);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: selectNotification);

    showNotification();

    Storage userData = new Storage("user.json");
    userData.readData().then((String uData) {
      Map<String, dynamic> uDataMap = jsonDecode(uData);
      token = uDataMap["token"];
      String exp = token["expiration"].toString();
      String tc = token["ticket"].toString();
      String bodyStr = '{ "token" : { "expiration" : $exp , "ticket" : "$tc"  } }';
      post('http://34.227.26.246/api/data/get', headers: headers, body: bodyStr).then((Response res) {
        
        print(res.body);

        List<dynamic> cls = json.decode(res.body);

        subject = cls[0]["subject"];
        startTime = cls[0]["startTime"];
        subject = cls[0]["room"];

        print(cls[0]["startTime"]);

        Storage routinedata = new Storage("routine.json");
        routinedata.writeData(res.body.toString()).then((File routineFile) {
          Navigator.pushReplacementNamed(context, "/app");
        });
      });
    });
  }

    Future<Void> selectNotification(String payload) {
    debugPrint("payload: $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: Text("KU-Connect"),
        content: Text(payload),
      )
    );
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,
        importance: Importance.Max,
        enableVibration: true
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, '$subject', 'You have class in $startTime in class $room', platform,
        payload: 'You have $subject' );
  }

    @override
  Widget build(BuildContext context) {
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