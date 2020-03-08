import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'package:ku/Storage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  dynamic token;
  String dataFromFile;

  _SignInState({Key key}) {
    dataFromFile = "Empty";
  }

@override
  void initState() {
    super.initState();

    Storage userData = new Storage("user.json");
    userData.readData().then((String uData) {
      if (uData != "error") {
        if (uData.length != 0) {
          Map<String, dynamic> uDataMap = jsonDecode(uData);
          DateTime now = new DateTime.now();
          int currentTime = now.millisecondsSinceEpoch;
          if (currentTime < uDataMap["token"]["expiration"]) {
            Storage routineData = new Storage("routine.json");
            routineData.readData().then((String rData) {
              if (rData == "null" || rData.length == 0) {
                Navigator.pushReplacementNamed(context, "/load");
              } else {
                Navigator.pushReplacementNamed(context, "/app");
              }
            });
          }
        }
      }
    });
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  String pass = '';
  String code = '';
  String errorRegister = '';

  getData() {  
    String body = '{"pass": "' + pass.trim() + '", "code": "' + code.trim() + '"}';

    post('http://34.227.26.246/api/user/signin', headers: headers, body: body).then((Response res) {
      Map<String, dynamic> signInRes = jsonDecode(res.body.toString());
      if (signInRes["Error"].toString() == "null") {
        token = signInRes["token"];
        String exp = token["expiration"].toString();
        String tc = token["ticket"].toString();
        String bodyStr = '{ "token" : { "expiration" : $exp , "ticket" : "$tc"  } }';
        Storage userData = new Storage("user.json");
        userData.writeData(bodyStr).then((File uFile) {
          Navigator.pushReplacementNamed(context, "/load");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = loading ? new Container(
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator()))
  ) : Container();
  return new Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      leading: Image.asset("assets/KU.png"),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text('Log In', style: TextStyle(color: Colors.black),),
      actions: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.person_add),
            label: Text('Register'),
            onPressed: () {
              Navigator.pushNamed(context, '/register',);
            }
        )
      ],
    ),

    body: Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
      child: Stack(children: <Widget>[ 
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'ID-Code'
                ),
                validator: (val) => val.isEmpty ? 'Enter ID-code' : null,
                onChanged: (val) {
                  setState(() => code = val);
                  _formKey.currentState.validate();
                },
                onTap: () {
                  setState(() =>
                    errorRegister = ''
                  );
                },
              ),

              SizedBox(height: 20.0),
              
              TextFormField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Password',
                    suffixIcon: IconButton(onPressed: _toggle,
                      icon: _obscureText
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    )
                ),
                validator: (val) => val.length !=4 ? 'Enter the 4 length pin' : null,
                onChanged: (val) {
                  setState(() => pass = val);
                  _formKey.currentState.validate();
                },
                onTap: () {
                  setState(() => errorRegister = '');
                },
              ),
              
              SizedBox(height: 20.0),
              
              RaisedButton(
                color: Colors.redAccent[100],
                child: Text('Sign In'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(()=> loading = true);
                    return getData();
                  }
                },
              ),
              
              SizedBox(height: 12.0),
              
              Text(
                errorRegister,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),

        Align(child: loadingIndicator, alignment: FractionalOffset.topRight,),
        
      ]
      ),
    ),
  );
  }
}