import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ku/Storage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

//initialize varaibles
    bool signedIn;
    bool isData;
    String token;
    String docs;

//initial state
 @override
  void initState() {
    super.initState();
    
    //check stored data for token
    token = "";
    Storage user = new Storage("user.json");
    user.readData().then((String recordedData) {

      //if no data route to signin page
      if (recordedData != "error") {
        if (recordedData.length == 0) {
          Navigator.pushReplacementNamed(context, "/signin");
        } 
        
        //if there is data
        else {
          Map<String, dynamic> userData = jsonDecode(recordedData);
          DateTime now = new DateTime.now();
          int currentTime = now.millisecondsSinceEpoch;

        //if there is no routine data, route to load page
          if (currentTime < userData["token"]["expiration"]) {
            Storage routineData = new Storage("routine.json");
            routineData.readData().then((String rData) {
              if (rData == "null" || rData.length == 0) {
                print("Routing to loader");
                Navigator.pushReplacementNamed(context, "/load");
              }
              
              //if there is routine data, route to app page
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

//UI of splash page
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