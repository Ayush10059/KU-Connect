import 'package:flutter/material.dart';

import 'package:ku/Home.dart';

class Routine extends StatelessWidget {

  final Record cls;

  Routine(this.cls);

//UI for Routine page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/KU.png'),
        backgroundColor: Colors.white,
        ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(cls.subject, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                    Text(cls.sCode, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              SizedBox(height: 20.0,),

              //lecturer
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Lecturer: " + cls.lecturer, style: TextStyle(fontSize: 18.0),),
              ),
              //classroom
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Classroom: " + cls.classroom, style: TextStyle(fontSize: 18.0),),
              ),
              //Department
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Department: " + cls.facSem, style: TextStyle(fontSize: 18.0),),
              ),
            ],
          ),
        ),
    );
  }
}