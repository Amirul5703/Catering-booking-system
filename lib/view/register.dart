import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username, password, nama;
  final _key = new GlobalKey<FormState>();
  bool _secureText = false;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response = await http.post('http://192.168.0.152/1/api/Register.php',
        body: {'nama': nama, 'username': username, 'password': password});

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else {
      print(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 17.0,
      ),
      child: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
            SizedBox(
              height: 50.0,
            ),
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return 'please insert full name';
                }
              },
              onSaved: (e) => nama = e,
              decoration: InputDecoration(
                labelText: 'nama',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return 'please insert username';
                }
              },
              onSaved: (e) => username = e,
              decoration: InputDecoration(
                labelText: 'username',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              obscureText: _secureText,
              onSaved: (e) => password = e,
              decoration: InputDecoration(
                labelText: 'password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                suffixIcon: IconButton(
                  onPressed: showHide,
                  icon: Icon(
                      _secureText ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
            ),
            ButtonTheme(
                minWidth: 600.0,
                height: 50.0,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: RaisedButton(
                        color: Colors.blueAccent[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        check();
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    )))
          ],
        ),
      ),
    )));
  }
}
