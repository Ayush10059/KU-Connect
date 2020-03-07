import 'package:flutter/material.dart';

import 'package:ku/signin.dart';
import 'package:ku/Register.dart';
import 'package:ku/Splash.dart';
import 'package:ku/App.dart';
import 'package:ku/Load.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Splash(),
      '/app': (context) => App(),
      '/signin': (context) => SignIn(),
      '/register': (context) => Register(),
      '/load' : (context) => Load(),
    }
  ));
}