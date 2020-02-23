import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool not = true;
  bool syn = true;
  String dropdown = '15 minutes';

  var time = ['2 minutes', '5 minutes', '10 minutes', '15 minutes', '30 minutes', '45 minutes'];

  void onOffNot(bool e, bool val) {
    setState(() {
      not = !not;
    });
  }
  void onOffSyn(bool e, bool val) {
    setState(() {
      syn = !syn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.fromLTRB(0.0,20.0,0.0,0.0),
            child: ListView(
                children: [
                  ListTile(
                      title: new Text('Notifications'),
                      trailing: new Switch(
                        value: not,
                        activeColor: Colors.redAccent,
                        onChanged: (bool e) => onOffNot(e, not),
                      ),
                  ),

                  ListTile(
                      title: new Text('Sync'),
                      trailing: new Switch(
                        value: syn,
                        activeColor: Colors.redAccent,
                        onChanged: (bool f) => onOffSyn(f, syn),
                      ),
                ),

                  ListTile(
                      title: new Text('Timer'),
                      trailing: new DropdownButton<String> (
                        value: dropdown,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.black87
                        ),
                        underline: Container(
                          height: 2,
                          color: Colors.redAccent,
                        ),
                        items: time.map((String timeList) {
                              return DropdownMenuItem<String>(
                                value: timeList,
                                child: Text(timeList),
                              );
                            }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdown = newValue;
                          });
                          },
                      ),
                  )
            ]
            )
        ),
      ),
    );
  }
}