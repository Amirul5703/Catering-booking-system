import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String nameP, qty, price, idusers;

  final _key = new GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idusers = preferences.getString('id');
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  submit() async {
    final response = await http.post(
        'http://192.168.0.152/1/api/Addproduct.php',
        body: {'nameP': nameP, 'qty': qty, 'price': price,  'idusers' : idusers});

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        Navigator.pop(context);
      });
    } else {
      print(message);
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
         key: _key,
        child:
          ListView(
           
            children: <Widget>[
              
              TextFormField(
                onSaved: (e) => nameP = e,
                decoration: InputDecoration(
                  labelText: 'produk name',
                ),
              ),
              TextFormField(
                onSaved: (e) => qty = e,
                decoration: InputDecoration(
                  labelText: 'quantity',
                ),
              ),
              TextFormField(
                onSaved: (e) => price = e,
                decoration: InputDecoration(
                  labelText: 'price',
                ),
              ),
              MaterialButton(
                onPressed: () {
                  check();
                },
                child: Text('Save'),
              )
            ],
          ),
        
      ),
    );
  }
}
