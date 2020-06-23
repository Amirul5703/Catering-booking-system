import 'package:flutter/material.dart';
import '../widget/HomwPageWidget.dart';
import 'package:test_1/model/productModel.dart';
import '../widget/FoodCategory.dart';

import '../pages/Budget.dart';
import './viewAll.dart';

class HomePage extends StatefulWidget {

 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String get dateCreated => null;

  String get id => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
           shrinkWrap: true,
           padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0, bottom: 600),
            children: <Widget>[
          HomeTopInfo(),
        FoodCategory(),
       
       
           
           SizedBox(
            height: 10.0,
          ),
          SearchField(),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bought Foods",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View all",
                  
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
        
              Column(
                
                children: <Widget>[
                 ViewAllPage(),

 Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bought Foods",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View all",
                  
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
SizedBox(
            height: 10.0,
          ),

                 
                  // Budget(),
                 // FoodCategory(),
                ],
              )
            ],
        )
          );
        
  }
}









