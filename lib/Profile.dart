import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ku/Storage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin{

//initialize data
  String name, email, faculty, joinYear, currentYear;
  String code;
  Future fut;

@override
void initState() {
  super.initState();

  fut = getData();
}

//function for 
Future getData() async {
  Storage user = new Storage("local.json");
  String uData = await user.readData();
  Map<String, dynamic> uDataMap = jsonDecode(uData);
  setState(() {
    name = uDataMap["name"];
    email = uDataMap["email"];
    code = uDataMap["code"];
    faculty = uDataMap["faculty"];
    joinYear = uDataMap["joinYear"];
    currentYear = uDataMap["currentYear"];
    return 0;
  });
}

//UI for Profile page
  @override
Widget build(BuildContext context) {
  super.build(context);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),

        body: FutureBuilder(
          future: fut,
          builder: (BuildContext context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
          return Container();

          else
            return Container(
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/KU.png', scale: 4.0,),

                    Padding(padding: EdgeInsets.only(top: 40.0),
                      child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                          children: <Widget>[

                            ListTile(
                              title: Center(child: Text(code, style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                            ),
                            

                            ListTile(
                              title: Center(child: Text('Batch: ' + joinYear, style: TextStyle(fontWeight: FontWeight.bold),)),
                              subtitle: Center(child: Text('Current year: ' + currentYear)),
                            ),

                            ListTile(
                              title: Center(child: Text(name, style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                              subtitle: Center(child: Text(email)),
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Center(child: FlatButton(
                          color: Colors.redAccent[100],
                          child: Text('Sign out'),
                          onPressed: () {
                            Storage user = new Storage("user.json");
                            user.writeData("").then((File fs) {
                              print("Data cleared...");
                              Navigator.pushReplacementNamed(context, "/signin");
                            });
                          }),
                        ),
                      )
                  ],
                ),
              ),
            );
          }
       ),
      )
  );
}

@override
bool get wantKeepAlive => true;
}