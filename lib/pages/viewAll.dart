import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/model/productModel.dart';

import 'package:http/http.dart' as http;
import '../view/productDetail.dart';
import 'package:flutter_rating/flutter_rating.dart';
//import '../widget/HomwPageWidget.dart';

class ViewAllPage extends StatefulWidget {
  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  String z;
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
          api['email'],
          api['desc'],
          api['rating'],
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
                            rating: double.parse(x.rating),
                            imagePath: Base64Decoder().convert(x.image_url),
                          ));
                    })),
      ],
    );
  }
}

class Test extends StatelessWidget {
  final String name;
  final Uint8List imagePath;
  final String id;
  final double rating;
  int starCount = 5;

  Test({this.name, this.imagePath, this.id, this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            child: Card(
              // color: Colors.amberAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
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
                        tag: id,

                        child:
                            //FittedBox(
                            // child:
                            Image.memory(
                          imagePath,
                          height: 150,
                          //width: 250,
                          fit: BoxFit.fill,
                        ),
                        // fit: BoxFit.fill
                      ))
                  //),
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
                width: 280,
              ),
            ),
            Positioned(
                left: 10.0,
                //bottom: 0.0,
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
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new StarRating(
                                  size: 19.0,
                                  rating: rating,
                                  color: Colors.orange,
                                  borderColor: Colors.grey,
                                  starCount: starCount,
                                ),
                                Text(
                                  "" ' $rating'.toString() + " Reviews",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
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
                              fontSize: 13.0,
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
                color: Colors.deepOrangeAccent[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
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
