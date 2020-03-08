import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:ku/Home.dart';
import 'package:ku/Storage.dart';
import 'package:ku/Routine.dart';

class Records extends StatefulWidget {
  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> with AutomaticKeepAliveClientMixin{

Future<List<Record>> sunday;
Future<List<Record>> monday;
Future<List<Record>> tuesday;
Future<List<Record>> wednesday;
Future<List<Record>> thursday;
Future<List<Record>> friday;
Future<List<Record>> saturday;

  @override
  void initState() {
    super.initState();
    sunday = getData(1);
    monday = getData(2);
    tuesday = getData(3);
    wednesday = getData(4);
    thursday = getData(5);
    friday = getData(6);
    saturday = getData(7);
  }

  Future <List <Record>> getData(int i) async {
    Storage routinedata = new Storage("routine.json");
    String rData = await routinedata.readData();
    var rDataMap =  jsonDecode(rData);
    List <Record> week = [];
    for (var rec in rDataMap) {
        if (i == rec["weekDay"])
          week.add(Record(rec["weekDay"], rec["subject"], rec["sCode"], rec["lecturer"], rec["classroom"], rec["facSem"], rec["startTime"], rec["endTime"]));
    }
    return week;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Routines", style: TextStyle(color: Colors.black)),
        leading: Image.asset('assets/KU.png'),
        backgroundColor: Colors.white,
      ),

      body: Container(
        child: ListView(
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Sunday', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            
            FutureBuilder(
              future: sunday,
              builder: (BuildContext context, AsyncSnapshot <List <Record>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container();

                else
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child : ListTile(
                              title: Text(snapshot.data[index].subject),
                              subtitle: Text(snapshot.data[index].startTime + "-" + snapshot.data[index].endTime),
                              onTap: () {
                                if (snapshot.data[0].lecturer != "0")
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Routine(snapshot.data[index]))
                                );
                              }
                            )
                        );
                      },
                    ),
                  );
              }
            ),Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Monday', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            
            FutureBuilder(
              future: monday,
              builder: (BuildContext context, AsyncSnapshot <List <Record>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container();

                else
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child : ListTile(
                              title: Text(snapshot.data[index].subject),
                              subtitle: Text(snapshot.data[index].startTime + "-" + snapshot.data[index].endTime),
                              onTap: () {
                                if (snapshot.data[0].lecturer != "0")
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Routine(snapshot.data[index]))
                                );
                              }
                            )
                        );
                      },
                    ),
                  );
              }
            ),Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Tuesday', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            
            FutureBuilder(
              future: tuesday,
              builder: (BuildContext context, AsyncSnapshot <List <Record>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container();

                else
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child : ListTile(
                              title: Text(snapshot.data[index].subject),
                              subtitle: Text(snapshot.data[index].startTime + "-" + snapshot.data[index].endTime),
                              onTap: () {
                                if (snapshot.data[0].lecturer != "0")
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Routine(snapshot.data[index]))
                                );
                              }
                            )
                        );
                      },
                    ),
                  );
              }
            ),Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Wednesday', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            
            FutureBuilder(
              future: wednesday,
              builder: (BuildContext context, AsyncSnapshot <List <Record>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container();

                else
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child : ListTile(
                              title: Text(snapshot.data[index].subject),
                              subtitle: Text(snapshot.data[index].startTime + "-" + snapshot.data[index].endTime),
                              onTap: () {
                                if (snapshot.data[0].lecturer != "0")
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Routine(snapshot.data[index]))
                                );
                              }
                            )
                        );
                      },
                    ),
                  );
              }
            ),Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Thursday', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            
            FutureBuilder(
              future: thursday,
              builder: (BuildContext context, AsyncSnapshot <List <Record>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container();

                else
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child : ListTile(
                              title: Text(snapshot.data[index].subject),
                              subtitle: Text(snapshot.data[index].startTime + "-" + snapshot.data[index].endTime),
                              onTap: () {
                                if (snapshot.data[0].lecturer != "0")
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Routine(snapshot.data[index]))
                                );
                              }
                            )
                        );
                      },
                    ),
                  );
              }
            ),Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Friday', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            
            FutureBuilder(
              future: friday,
              builder: (BuildContext context, AsyncSnapshot <List <Record>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                return Container();

                else
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child : ListTile(
                              title: Text(snapshot.data[index].subject),
                              subtitle: Text(snapshot.data[index].startTime + "-" + snapshot.data[index].endTime),
                              onTap: () {
                                if (snapshot.data[0].lecturer != "0")
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Routine(snapshot.data[index]))
                                );
                              }
                            )
                        );
                      },
                    ),
                  );
              }
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}