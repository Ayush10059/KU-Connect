import 'package:flutter/material.dart';

class Routine extends StatefulWidget {
  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 2.0,
            child: ListTile(
              title: Text('Sunday'),
              onTap: () {

              },
            ),
          )
        ],
      )
    );
  }
}
