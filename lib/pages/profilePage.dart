import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/order.dart' show Orders;

import '../widget/drawer.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/orderHist.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  final list = new List<OrderItem>();
  _getData() async {
    list.clear();

    setState(() {
      _isLoading = true;
    });

    final response = await http.get('http://192.168.0.152/1/api/GetOrder.php');
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
        _isLoading = false;
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
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Your Orders list',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                 
                                  Text(x.datetimeEvent),
                                ],
                              ),
                            ],
                          ),
                        ),
                        new ExpansionTile(
                            title: new Text(x.title),
                            
                            children: <Widget>[
                              new ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 4.0,
                                      ),
                                      Text(x.packageName),
                                      Container(
                                        height: 4.0,
                                      ),
                                      Text(x.personPax),
                                      Container(
                                        height: 4.0,
                                      ),
                                      //Text('Total person :'),
                                    ],
                                  ),
                                  trailing: Text('RM ' + x.price),
                                  
                                  
                                  )
                            ]),
                      ],
                    ),
                  );
                }));
  }
}
