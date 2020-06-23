import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/model/productModel.dart';

import 'package:http/http.dart' as http;
import '../view/productDetail.dart';
//import '../widget/HomwPageWidget.dart';

class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  var loading = false;

  final list = new List<ProductModel>();
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
        final ab = new ProductModel(
          api['CatererId'],
          api['CatererName'],
          api['CatererRating'],
          api['image_url'],
           api['phoneNum'],
          api['Description'],
          api['email'],
               api['rating'],
          // api['packageName'],
          // api['packagePrice'],
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
    return Column(
      children: <Widget>[
        Container(
            height: 270.0,
            child: loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, i) {
                      final x = list[i];
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailProduct(x)));
                          },
                          child: Test(
                            name: x.CatererName,
                            id: x.CatererId,
                          ));
                    })),
      ],
    );
  }
}

class Test extends StatelessWidget {
  final String name;
  final String imagePath;
  final String id;

  Test({this.name, this.imagePath, this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            child: Card(
              color: Colors.amberAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      child: Hero(
                        tag: '423',
                        child: Image.network(
                          'https://static.imoney.my/articles/wp-content/uploads/2019/09/buffet.jpg',
                          height: 150,
                          width: 290,
                        ),
                      )),
              
                ],
              ),
            ),
          ),
        ],
      ),
     
              Container(
                height: 45,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      child: Container(
                        // height: 10,
                        width: 290,
                       
                      ),
                    ),
                    Positioned(
                        left: 10.0,
                        bottom: 6.0,
                        right: 10.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 16.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "(" '45'.toString() + " Reviews)",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '2.5 KM',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),

                            // Text(x.qty),
                          ],
                        ))
                  ],
                ),
              
            ),
          
        
      
      
     Container(
       child: Row(
            children: <Widget>[
              
              Container(
                
                child: Card(
                  color: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          child: Container(
                            height: 40,
                            width: 200,
                          )),
                      Positioned(
                          left: 44.0,
                          bottom: 10.0,
                          right: 10.0,
                          //top: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Click for detail',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  ),
                                ],
                              ),

                              // Text(x.qty),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
     ),
      
    ]);
  }
}
