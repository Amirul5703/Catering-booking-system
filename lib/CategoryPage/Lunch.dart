// import 'package:flutter/material.dart';
// import '../widget/HomwPageWidget.dart';
// import 'package:test_1/model/productModel.dart';
// import '../widget/FoodCategory.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../view/productDetail.dart';

// class HqomePage extends StatefulWidget {
//   final String CategoryId;
//   final String CategoryName;

//   HqomePage(this.CategoryId,this.CategoryName);

//   @override
//   _HqomePageState createState() => _HqomePageState();
// }

// class _HqomePageState extends State<HqomePage> {
//   var loading = false;
//   final list = new List<ProductModel>();
//   _getData() async {
//     list.clear();

//     setState(() {
//       loading = true;
//     });

//     final response = await http.get(
//         'http://192.168.0.152/1/api/Wedding.php?CategoryId=${widget.CategoryId}');
//     if (response.contentLength == 2) {
//     } else {
//       final data = jsonDecode(response.body);
//       data.forEach((api) {
//         final ab = new ProductModel(
//           api['CatererId'],
//           api['CatererName'],
//           api['CatererRating'],
//           // api['PackageId'],
//           // api['packageName'],
//           // api['packagePrice'],
//         );
//         list.add(ab);
//       });
//       setState(() {
//         loading = false;
//       });
//     }
//   }

//   @override // untuk get data rfom databse
//   void initState() {
//     super.initState();
//     _getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(






// resizeToAvoidBottomPadding: false,
//       body: Stack(
//         children: <Widget>[
//           NestedScrollView(
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return [
//                 new SliverAppBar(
//                     floating: false,
//                     pinned: true,
//                     elevation: 50,
//                     expandedHeight: 300.0,
//                      backgroundColor: Colors.green,
//                     flexibleSpace: FlexibleSpaceBar(
//                         centerTitle: true,
//                         title: Text(widget.CategoryName,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16.0,
//                             )),
//                         background: Stack(children: <Widget>[
                          
//                           Hero(
//                             tag: widget.CategoryId,
//                             child: Image.network(
//                                 'https://static.imoney.my/articles/wp-content/uploads/2019/09/buffet.jpg'),
//                           ),
//                           Positioned(
//                             left: 0.0,
//                             bottom: 0.0,
//                             width: 500.0,
//                             height: 200.0,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                       begin: Alignment.bottomCenter,
//                                       end: Alignment.topCenter,
//                                       colors: [
//                                     Colors.black38,
//                                     Colors.black12
//                                   ])),
//                             ),
//                           ),
//                         ]))),
                
//               ];
//             },





      
//         body: Container(
//             margin: EdgeInsets.only(right: 10.0, left: 10.0),
//             child: loading
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     //physics: NeverScrollableScrollPhysics(),

//                     //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     //  crossAxisCount: 1,
//                     // ),
//                     itemCount: list.length,
//                     itemBuilder: (context, i) {
//                       final x = list[i];
//                       return InkWell(
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => DetailProduct(x)));
//                           },
//                           child: Card(
//                               color: Colors.amberAccent,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Column(children: <Widget>[
//                                 Stack(children: <Widget>[
//                                   Stack(
//                                     children: <Widget>[
//                                       ClipRRect(
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(15),
//                                             topRight: Radius.circular(15),
//                                             bottomLeft: Radius.circular(15),
//                                             bottomRight: Radius.circular(15),
//                                           ),
//                                           child: Hero(
//                                             tag: x.CatererId,
//                                             child: Image.network(
//                                               'https://static.imoney.my/articles/wp-content/uploads/2019/09/buffet.jpg',
//                                             ),
//                                           )),
//                                       Positioned(
//                                         left: 0.0,
//                                         bottom: 0.0,
//                                         width: 385.0,
//                                         height: 60.0,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                               gradient: LinearGradient(
//                                                   begin: Alignment.bottomCenter,
//                                                   end: Alignment.topCenter,
//                                                   colors: [
//                                                     Colors.black,
//                                                     Colors.black12
//                                                   ])),
//                                         ),
//                                       ),
//                                       Positioned(
//                                           left: 10.0,
//                                           bottom: 10.0,
//                                           right: 10.0,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: <Widget>[
//                                                   Text(
//                                                     x.CatererName,
//                                                     style: TextStyle(
//                                                         fontSize: 18.0,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: Colors.white),
//                                                   ),
//                                                   Row(
//                                                     children: <Widget>[
//                                                       Icon(
//                                                         Icons.star,
//                                                         color: Theme.of(context)
//                                                             .primaryColor,
//                                                         size: 16.0,
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color: Theme.of(context)
//                                                             .primaryColor,
//                                                         size: 16.0,
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color: Theme.of(context)
//                                                             .primaryColor,
//                                                         size: 16.0,
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color: Theme.of(context)
//                                                             .primaryColor,
//                                                         size: 16.0,
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         color: Theme.of(context)
//                                                             .primaryColor,
//                                                         size: 16.0,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 10.0,
//                                                       ),
//                                                       Text(
//                                                         "(" '45'.toString() +
//                                                             " Reviews)",
//                                                         style: TextStyle(
//                                                             color: Colors.grey),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: <Widget>[
//                                                   Text(
//                                                     '2.5 KM',
//                                                     style: TextStyle(
//                                                         fontSize: 15.0,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: Colors.white),
//                                                   ),
//                                                   Text('',
//                                                       style: TextStyle(
//                                                           color: Colors.grey))
//                                                 ],
//                                               ),
//                                               // Text(x.qty),
//                                             ],
//                                           ))
//                                     ],
//                                   ),
//                                 ]),
//                               ])));
//                     })))]));
//   }
// }
