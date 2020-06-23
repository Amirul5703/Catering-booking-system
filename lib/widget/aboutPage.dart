import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:pokedex/configs/AppColors.dart';
import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/model/productModel.dart';

import 'package:http/http.dart' as http;
import '../view/productDetail.dart';

import 'package:flutter_rating/flutter_rating.dart';

class PokemonAbout extends StatelessWidget {
  final String desc;

  final String email;
  final String phone;
  final double rating;
  int starCount = 5;

  PokemonAbout(this.desc, this.email, this.phone, this.rating);

  Widget _buildSection(String text, {List<Widget> children, Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style:
              TextStyle(fontSize: 16, height: 0.8, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 22),
        if (child != null) child,
        if (children != null) ...children
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
        height: 0.8,
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      child: Text(
        desc,
        textAlign: TextAlign.justify,
        style: TextStyle(height: 1.3),
      ),
    );
  }

  Widget _buildHeightWeight() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 8),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: new NetworkImage(
                        "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        Column(
            children: <Widget>[
              Container(
                width: 30.0,
                
             
              ),
            ],
          ),
          Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildLabel("Contact"),
              Column(
                
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 // _buildLabel("Contact"),
                  SizedBox(height: 11),
                  Text(phone, style: TextStyle(height: 0.8))
                ],
              ),
              SizedBox(
                height: 19,
              ),
               _buildLabel("Email"),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                 //
                  SizedBox(height: 11),
                  Text(email, style: TextStyle(height: 0.8))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreeding() {
    return _buildSection("Rating", children: [
      Column(
        children: <Widget>[
          StarRating(
            size: 50.0,
            rating: rating,
            color: Colors.orange,
            borderColor: Colors.grey,
            starCount: starCount,
          ),
          Text(
            "" ' $rating'.toString() + " Reviews",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
      SizedBox(height: 18),
    ]);
  }

  Widget _buildLocation() {
    return _buildSection("Location",
        child: AspectRatio(
          aspectRatio: 2.253,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage("assets/gamba/img09.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }

  Widget _buildTraining() {
    return _buildSection(
      "Term and Condition",
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: _buildLabel("Base EXP")),
          Expanded(flex: 3, child: Text("64")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),

      child: Column(
        children: <Widget>[
          _buildDescription(),
          SizedBox(height: 15),
          _buildHeightWeight(),
          SizedBox(height: 20),
          _buildBreeding(),
          SizedBox(height: 0),
          _buildLocation(),
          SizedBox(height: 26),
          _buildTraining(),
        ],
      ),
      // builder: (context, child) {

      //return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 19, horizontal: 27),
      //physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
      // child: child,
    );
  }
}
