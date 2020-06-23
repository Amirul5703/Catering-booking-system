
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
class ProductModel{



final String CatererId;
final String CatererName;
final String CatererRating;
final String image_url;
final String phoneNum;
final String email;
final String desc;
final String rating;

//final String Idusers;
//final String Idusers;


   ProductModel(this.CatererId, this.CatererName, this.CatererRating, this.image_url, this.phoneNum,  this.email,this.desc, this.rating );

}





// class ProductMenuModel{

// final String id;
// final String menu1;
// final String menu2;
// final String menu3;
// final String menu4;
// final String menu5;
// final String menu6;

//   ProductMenuModel(this.id, this.menu1, this.menu2, this.menu3, this.menu4, this.menu5, this.menu6);



// }
