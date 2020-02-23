import 'package:flutter/material.dart';
//import 'package:http/http.dart';

import 'package:ku/Home.dart';
import 'package:ku/Profile.dart';
import 'package:ku/Settings.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        child: Scaffold(

          bottomNavigationBar: BottomAppBar(
            child: TabBar(
              indicatorColor: Colors.deepOrangeAccent,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.home, color: Colors.redAccent,)),
                    Tab(icon: Icon(Icons.account_box, color: Colors.redAccent,)),
                    Tab(icon: Icon(Icons.settings, color: Colors.redAccent,)),
                  ],
              )
            ),

          body: TabBarView(
            children: <Widget>[
              Home(),
              Profile(),
              Settings(),
            ],
          ),
        ),
        length: 3,
      ),
    );
  }
}