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
    String dataFromFile;
    dynamic token;

  _LoadingState({Key key}) {
    dataFromFile = "Empty";
  }

 @override
  void initState() {
    super.initState();
    print("Token Printed!!!");
    Storage userData = new Storage("user.json");
    userData.readData().then((String uData) {
      Map<String, dynamic> savedUser = jsonDecode(uData);
      Map<String, dynamic> tk = savedUser["token"];
      print(tk);
      setState(() {
        token = tk;
      });
    });
//    Storage storage = new Storage("data.json");
//    storage.readData().then((String recordedData) {
//      Map<String, dynamic> jsonData = jsonDecode(recordedData);
//      print("Data: ");
//      List dt = jsonData["docs"];
//      for (int i = 0; i < 6; i++) {
//        if (now.weekday == i) {
//          for (int j = 0; j < dt.length; j++) {
//            int wd = jsonData["docs"][j]["weekDay"];
//            if (wd == i) {
//              print(jsonData["docs"][j]["time"]);
//              //ti.add(jsonData["docs"][j]["time"].toString());
//            }
//          }
//        }
//      }
//      setState(() {
//        dataFromFile = recordedData;
//        t = ti;
//      });
//      print(ti);
//    });
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
  
    Future<File> data() async {
  
    var body = jsonEncode(token);

    Response response = await post('http://34.227.26.246/api/data/get', headers: headers, body: body);

    String dataToStore = response.body.toString();
    print(dataToStore);
    Storage storage = new Storage("data.json");

    Navigator.pushNamed(context, '/App');
    return storage.writeData(dataToStore);
  }
}