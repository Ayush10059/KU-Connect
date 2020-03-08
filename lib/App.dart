import 'package:flutter/material.dart';

import 'package:ku/SignIn.dart';
import 'package:ku/Home.dart';
import 'package:ku/Profile.dart';
import 'package:ku/Records.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signin': (context) => SignIn(),
      },
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: TabBar(
              indicatorColor: Colors.deepOrangeAccent,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.home, color: Colors.redAccent,)),
                    Tab(icon: Icon(Icons.reorder, color: Colors.redAccent,)),
                    Tab(icon: Icon(Icons.account_box, color: Colors.redAccent,)),
                  ],
              )
            ),

          body: TabBarView(
            children: <Widget>[
              Home(),
              Records(),
              Profile(),
            ],
          ),
        ),
      ),
    );
  }
}