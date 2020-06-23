import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:test_1/model/productModel.dart';

import 'package:http/http.dart' as http;
import '../model/orderHist.dart';
import '../model/cart.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  var loading = false;
  


  final list = new List<OrderItem>();
  _getData() async {
    list.clear();

    setState(() {
      loading = true;
    });

    final response =
        await http.get('http://192.168.0.152/1/api/GetProduct.php');
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new OrderItem(
          api['id'],
          api['title'],
          api['quantity'],
          api['price'],
          api['datetimeEvent'],
          api['instruction'],
          api['packageName'],
          api['personPax'],
        );
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  @override // untuk get data rfom databse
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
            //height: 270.0,
            child: loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, i) {
                      final x = list[i];
                      return Card(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new ExpansionTile(
                            title: new Text("Johor"),
                            
                         
                            children: <Widget>[
                              new ListTile(
                                title: new Text("j"),
                              )
                            ]
                        ),
                      ]));
  }
    ));}
}