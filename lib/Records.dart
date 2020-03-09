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

List<Future<List<Record>>> d=[];

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < 7; i++)
      d.add(getData(i+1));
  }

  Future <List <Record>> getData(int i) async {
    Storage routinedata = new Storage("routine.json");
    String rData = await routinedata.readData();
    var rDataMap =  jsonDecode(rData);
    List<Record> week = [];
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
          children: List.generate(d.length, (index) {
          List <String> week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", ""];
            return  Container(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(week[index], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  ),

                  FutureBuilder<List<Record>>(
                    future: d[index],
                    initialData: [],
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
                                  child: ListTile(
                                    title: Text(snapshot.data[index].subject),
                                    subtitle: Text(snapshot.data[index].startTime + " - " + snapshot.data[index].endTime),
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
                  )
                ],
              ),
            );
          }
          )
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}