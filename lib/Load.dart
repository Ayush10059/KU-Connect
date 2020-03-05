import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

import 'package:ku/Storage.dart';
import 'package:ku/signin.dart';

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {

  String errorRegister = "";
  Map<String, dynamic> token;

  Future<String> check = Future<String>.delayed(
  Duration(seconds: 2)
  );

    @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: FutureBuilder(
            future: check,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            color: Colors.blueGrey[300],
            child: Center(
              child: SpinKitChasingDots(
              color: Colors.blueGrey[500],
              size: 50.0,
              ),
            ),
          );
        }
      )
    );
  }

  @override
  void initState() {
    super.initState();
    Storage userData = new Storage("user.json");
    userData.readData().then((String uData) {
      Map<String, dynamic> uDataMap = jsonDecode(uData);
      token = uDataMap["token"];
      String exp = token["expiration"].toString();
      String tc = token["ticket"].toString();
      String bodyStr = '{ "token" : { "expiration" : $exp , "ticket" : "$tc"  } }';
      post('http://34.227.26.246/api/data/get', headers: headers, body: bodyStr).then((Response res) {
        Storage routinedata = new Storage("routine.json");
        routinedata.writeData(res.body.toString()).then((File routineFile) {
          print("Data written to file...");
          print(res.body.toString());
          Navigator.pushReplacementNamed(context, "/app");
        });
      });
    });
  }
}