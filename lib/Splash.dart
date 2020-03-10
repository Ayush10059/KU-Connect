import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ku/Storage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

    bool signedIn;
    bool isData;
    String token;
    String docs;

 @override
  void initState() {
    super.initState();
    
    token = "";
    Storage user = new Storage("user.json");
    user.readData().then((String recordedData) {
      if (recordedData != "error") {
        if (recordedData.length == 0) {
          Navigator.pushReplacementNamed(context, "/signin");
        } 
        
        else {
          Map<String, dynamic> userData = jsonDecode(recordedData);
          DateTime now = new DateTime.now();
          int currentTime = now.millisecondsSinceEpoch;

          if (currentTime < userData["token"]["expiration"]) {
            Storage routineData = new Storage("routine.json");
            routineData.readData().then((String rData) {
              if (rData == "null" || rData.length == 0) {
                print("Routing to loader");
                Navigator.pushReplacementNamed(context, "/load");
              }
              
              else {
                print("Routing to main");
                Navigator.pushReplacementNamed(context, "/app");
              }
            });
          }
          
          else {
            print("Routing to signin");
            Navigator.pushReplacementNamed(context, "/signin");
          }
        }
      }
      
      else {
        print("File not found. Routing...");
        Navigator.pushReplacementNamed(context, "/signin");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset('assets/KU_logo.png',)
      ),
    );
  }
}