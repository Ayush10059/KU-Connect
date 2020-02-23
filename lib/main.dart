//import 'dart:js';

import 'package:flutter/material.dart';

import 'package:ku/signin.dart';
import 'package:ku/Register.dart';
import 'package:ku/loading.dart';
import 'package:ku/App.dart';

bool signedIn;

void main() => runApp(MaterialApp(

  routes: {
    '/': (context) => signedIn ? SignIn() : App(),
    '/App': (context) => App(),
    '/signin': (context) => SignIn(),
    '/register': (context) => Register(),
    '/loading': (context) => Loading()
  }
));