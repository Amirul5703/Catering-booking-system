import 'package:flutter/material.dart';
import 'package:test_1/pages/MainPage.dart';

import '../model/productModel.dart';
import 'dart:typed_data';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/FoodCategory.dart';
import '../CategoryPage/Wedding.dart';

// Model

class FoodCard extends StatelessWidget {
  final String categoryName;
  final Uint8List imagePath;
  final String numberOfItems;

  FoodCard({this.categoryName, this.imagePath, this.numberOfItems});

  @override
  Widget build(BuildContext context) {
    return Card(
            color: Colors.redAccent,
                          
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child:  Column(children: <Widget>[
            Stack(children: <Widget>[
          
               Image.memory(
              imagePath,
      height: 102.0,
      width: 110,
      
      ),
              // Positioned(
              //   left: 0.0,
              //   bottom: 2.0,
              //   width: 110.0,
              //   height: 7.0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //         gradient: LinearGradient(
              //             begin: Alignment.bottomCenter,
              //             end: Alignment.topCenter,
              //             colors: [Colors.black38, Colors.black12])),
              //   ),
              // ),
              Positioned(
                left: 10.0,
                bottom: 9.0,
                right: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          categoryName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ]),
        );
  }
}

class FoodCategory extends StatefulWidget {
  @override
  _FoodCategoryState createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  var loading = false;


  
  final list = new List<CatFood>();
  _getData() async {
    list.clear();

     setState(() {
      loading = true;
    });


    final response =
        await http.get('http://192.168.0.152/1/api/GetCategory.php');
        
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new CatFood(
          api['CategoryId'],
          api['CategoryName'],
          api['image_urlCat'],
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
      height: 110.0,
      width: 130,
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
                    builder: (context) =>
                        HqomePage(x.CategoryId, x.CategoryName, x.image_urlCat)));
              },
              child: FoodCard(
                categoryName: x.CategoryName,
                numberOfItems: x.CategoryId,
                imagePath: Base64Decoder().convert(x.image_urlCat) ,
              ));
        },
      ),
    );
  }
}
