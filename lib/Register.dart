import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:ku/Splash.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool loading = false;

  String name = '';
  String email = '';
  String code = '';
  String errorRegister = '';

  getData() async {
    Map<String, String> headers = {"Content-type": "application/json"};

    String body = '{"name": "' + name.trim() + '", "email": "' + email.trim() + '", "code": "' + code.trim() + '"}';
    print(body);
    Response response = await post('http://34.227.26.246/api/user/create', headers: headers, body: body);

    Map<String, dynamic> resp = jsonDecode(response.body);

    if(resp["Error"] != null)
      setState(() {
        errorRegister = resp["Error"];
      });
    else {
      setState(() {
        errorRegister = '';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Splash() :  Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset("assets/KU.png"),
        backgroundColor: Colors.white,
        title: Text('Join KU Connect', style: TextStyle(color: Colors.black),),

      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
        child: Form(

          child: Column(
            children: <Widget>[

              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Your Name'
                ),
                onChanged: (val){
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'E-mail'
                ),
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.branding_watermark),
                    hintText: 'ID-Code'
                ),
                onChanged: (val){
                  setState(() => code = val);
                },
              ),

              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.redAccent[100],
                child: Text('Register'),
                onPressed: (){
                getData();
                Navigator.pushNamed(context, '/signin');
                }
              ),
              Text(
                errorRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


