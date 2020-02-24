//import 'dart:js';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ku/signin.dart';
import 'package:ku/Register.dart';
import 'package:ku/loading.dart';
import 'package:ku/App.dart';

import 'package:ku/Storage.dart';


bool signedIn = false;

void main() {

  // String token = "";
  
  // Storage user = new Storage("user.json");
  // user.readData().then((String recordedData) {
  //   Map<String, dynamic> jsonData = jsonDecode(recordedData);
  //   print(" SAVED ");
  //   token = jsonData["token"].toString();
  // });

  // signedIn = token.length > 0 ? true : false;

  runApp(MaterialApp(
    routes: {
      '/': (context) => Loading(),
      '/App': (context) => App(),
      '/signin': (context) => SignIn(),
      '/register': (context) => Register(),
    }
  ));
}
