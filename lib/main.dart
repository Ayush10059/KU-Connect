import 'package:flutter/material.dart';

import 'package:ku/signin.dart';
import 'package:ku/Register.dart';
import 'package:ku/loading.dart';
import 'package:ku/App.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Loading(),
      '/App': (context) => App(),
      '/signin': (context) => SignIn(),
      '/register': (context) => Register(),
    }
  ));
}
