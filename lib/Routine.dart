import 'package:flutter/material.dart';

import 'package:ku/Home.dart';

class Routine extends StatelessWidget {

  final Record cls;

  Routine(this.cls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cls.subject),
        ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Subject Code: " + cls.sCode),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Lecturer: " + cls.lecturer),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Classroom: " + cls.classroom),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Department / Semester: " + cls.facSem),
              ),
            ],
          ),
        )
      ),
    );
  }
}