import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Center(child: Icon(Icons.account_circle, size: 150.0,)),

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
                onPressed: () {},
              ),
              )
          ],
        ),
      ),
    );
  }
}
