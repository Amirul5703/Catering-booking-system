import 'package:flutter/material.dart';
//import '../data/category_data.dart';
import '../model/productModel.dart';

// Model
//import '../model/category_model.dart';

class HomeTopInfo extends StatelessWidget{

  
  
   //final ProductModel model;
   //HomeTopInfo(this.model);

  final textStyle = TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);
  
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              
              Text("What would", style: textStyle),
              Text("you like to eat?", style: textStyle,),
            
            ],
          ),
          Icon(Icons.notifications_none, size: 30.0, color: Theme.of(context).primaryColor,),
        ],
      ),
    );
  }
}



class SearchField extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      child: TextField(
        style:TextStyle(color: Colors.black, fontSize: 16.0),
        cursorColor: Theme.of(context).primaryColor,
        decoration:InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
          suffixIcon: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: Icon(
                Icons.search,
                color: Colors.black,
              )
          ),
          border:InputBorder.none,
          hintText: "Search Foods"
        )
      ),
    );
  }
}




