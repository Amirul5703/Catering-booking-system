// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test_1/model/productModel.dart';
// import 'package:test_1/view/addProduct.dart';
// import 'package:http/http.dart' as http;
// import '../view/productDetail.dart';
// import '../model/productModel.dart';


// class HomePage extends StatefulWidget {
 
//   @override
//   _MenuState createState() => _MenuState();
// }

// class _MenuState extends State<HomePage> {


//   var loading = false;

//   final list = new List<ProductMenuModel>();
//   _getData() async {
//     list.clear();

//     setState(() {
//       loading = true;
//     });
    

//     final response =
//         await http.get('http://192.168.43.250/1/api/ProductMenu.php/' );
//     if (response.contentLength == 2) {
//     } else {
//       final data = jsonDecode(response.body);
//       data.forEach((api) {
//         final ac = new ProductMenuModel(
//           api['id'],
//           api['menu1'],
//           api['menu2'],
//           api['menu3'],
//           api['menu4'],
//           api['menu5'],
//           api['menu6'],
//         );
//         list.add(ac);
//       });
//     }
//   }


//   @override                 // untuk get data rfom databse
//   void initState() {
//     super.initState();
//     _getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  GridView.builder(
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                 ),
//                 itemCount: list.length,
//                 itemBuilder: (context, i) {
//                   final x = list[i];
//                   return InkWell(
                   
//                     child: Column(
//                       children: <Widget>[

                         
//                                 Text(x.menu1),
//                                 Text(x.menu2),
//                                 Text(x.menu3),
//                                 Text(x.menu4),
//                                 //Text(x.menu5),

//                                 Text(x.menu6),
                             
//                         RaisedButton(
//                           onPressed: () {},
//                           color: Colors.orange,
//                           child: Text('Buy',
//                               style: TextStyle(color: Colors.white)),
//                         )
//                       ],
//                     ),
//                   );
//                 }

             
//                 ); 
//   }
// }


// ///body: Center(
//      // child: const Text('Press the button below!')
//    // ),
//    // floatingActionButton: FloatingActionButton(
//      // onPressed: () {

//          //Navigator.of(context).push(
//                         //MaterialPageRoute(builder: (context) =>  AddProduct()));

//         // Add your onPressed code here!
//      // },
//       //child: Icon(Icons.navigation),
//      // backgroundColor: Colors.green,
//     //),
//   //);