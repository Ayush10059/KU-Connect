import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

import 'package:ku/Storage.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
    bool signedIn;
    dynamic token;

 @override
  void initState() {
    super.initState();
    String token = "";
    print("Here");
    Storage user = new Storage("user.json");
    user.readData().then((String recordedData) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(recordedData);
        print(" SAVED ");
        token = jsonData["token"].toString();
        signedIn = token.length > 0 ? true : false;
      } catch (e) {
        print("error reading json");
        print(e);
        signedIn = false;
      }
      if (signedIn)
        Navigator.pushReplacementNamed(context, "/App");
      else
        Navigator.pushReplacementNamed(context, "/signin");
    });
}

  @override
  Widget build(BuildContext context) {
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
}