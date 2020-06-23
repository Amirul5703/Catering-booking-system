import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './view/login.dart';
import './model/cart.dart';
import './pages/cartPage.dart';
import './model/order.dart';
import './pages/profilePage.dart';

  void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(
        //   value: ProductModel(),
        // ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),

         ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            
            //primarySwatch: Colors.,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: Login(),
          routes: {
             CartScreen.routeName: (ctx) => CartScreen(),
             
            OrdersScreen.routeName: (ctx) => OrdersScreen()
            
            }),
          
    );
  }
}