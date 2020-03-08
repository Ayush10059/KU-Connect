import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ku/Settings.dart';
import 'package:ku/Storage.dart';
import 'package:ku/signin.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin{

  @override
Widget build(BuildContext context) {
  super.build(context);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(icon: Icon(
              Icons.settings, color: Colors.black,),
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Settings())
                  );
                }
            )
          ],
        ),

        body: ListView(
          children: [
            Center(child: Image.asset('assets/KU.png', scale: 4.0,)),

            Padding(padding: EdgeInsets.only(top: 50.0)),

            Center(child: Text('Ayush Bajracharya', style:  TextStyle(fontWeight: FontWeight.bold),)),
            Center(child: Text('Bsc. Computer Science')),
            Center(child: Text('School of Science')),

            Padding(padding: EdgeInsets.only(top: 30.0)),

            Center(child: Text('SUSSCS18004', style:  TextStyle(fontWeight: FontWeight.bold),)),

            Padding(padding: EdgeInsets.only(top: 50.0)),

            Center(child: FlatButton(
              color: Colors.redAccent[100],
              child: Text('Logout'),
              onPressed: () {
                Storage user = new Storage("user.json");
                user.writeData("").then((File fs) {
                  print("Data cleared...");
                  Navigator.pushReplacementNamed(context, "/signin");
                });
              }),
            )
          ],
        ),
      ),
    );
  }

@override
bool get wantKeepAlive => true;
}