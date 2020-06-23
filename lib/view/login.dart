import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/pages/MainPage.dart';
import '../screens/main_screen.dart';
import './register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, sigIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username, password;
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
      print("$username, $password");
      login();
    }
  }

  login() async {
    final response = await http.post('http://192.168.0.152/1/api/login.php',
        body: {'username': username, 'password': password});

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String usernameA = data['username'];
    String namaA = data['nama'];
    String idusers = data['idusers'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.sigIn;
        savePre(value, usernameA, namaA, idusers);
      });
      print(message);
    } else {
      print(message);
    }
  }

  savePre(int value, String username, String nama, String idusers) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt('value', value);
      preferences.setString('nama', nama);
      preferences.setString('username', username);
      preferences.setString('idusers', idusers);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');

      _loginStatus = value == 1 ? LoginStatus.sigIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt('value', null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return  Scaffold(
            body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 17.0,
            ),
            child: Form(
              key: _key,
              child: Container(
             
                child: ListView(
              shrinkWrap: true,
                // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'img/1.png',
                      height: 75,
                    ),

                    SizedBox(
                      height: 50.0,
                    ),
                    

                    TextFormField(
                        validator: (e) {
                          if (e.isEmpty) {
                            return 'please insert username';
                          }
                        },
                        onSaved: (e) => username = e,
                        decoration: InputDecoration(
                          hintText: "Your email or username",
                          hintStyle: TextStyle(
                            color: Color(0xFFBDC2CB),
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),

                    TextFormField(
                      obscureText: _secureText,
                      onSaved: (e) => password = e,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Color(0xFFBDC2CB), fontSize: 18.0),
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.all(4.0),
                    ),


                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Forgotten Password?",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    //const SizedBox(height: 9, width: 2,),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.blueAccent[100],
                          padding: EdgeInsets.symmetric(
                              vertical: 9.0, horizontal: 0.0),
                          onPressed: () {
                            check();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: Text('Create account', textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));

        break;
      case LoginStatus.sigIn:
        return MainScreen(signOut);
        break;
      default:
    }
  }
}
