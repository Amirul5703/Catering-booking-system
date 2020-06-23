import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/model/productModel.dart';
import 'package:test_1/view/addProduct.dart';
import 'package:http/http.dart' as http;
import '../model/getpackage.dart';
import '../view/productDetail.dart';
import '../view/builditem.dart';
//import '../widget/HomwPageWidget.dart';

class PackagePage extends StatefulWidget {
// final String CatererId,packageName,packagePrice;

// PackagePage(this.CatererId,this.packageName,this.packagePrice);

  final String CatererId;

  PackagePage(this.CatererId);

  @override
  _PackagePageState createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  var loading = false;
Uint8List imagePath;
  final list = new List<GetPackage>();
  _getData(String id) async {
    list.clear();

    setState(() {
      loading = true;
    });

    final response = await http.get(
        'http://192.168.0.152/1/api/GetPackage.php?CatererId=${widget.CatererId}');
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new GetPackage(
            api['PackageId'],
          api['CatererId'],
          api['packageName'],
          api['packagePrice'],
          api['NumOfPax'],
           api['CatererName'],
           

          // api['MenuId'],
          api['Menu1'],
            api['imageP'],
          // api['Menu2'],
          // api['Menu3'],
          // api['Menu4'],
          // api['Menu5'],
          // api['Menu6'],
          // api['Menu7'],
          // api['Menu8'],
          // api['Menu9'],
          // api['Menu10'],
          // api['Menu11'],
          // api['Menu12'],
      
          
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
    _getData("CatererId");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BuildItem(x)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child: Image.memory(

                                          imagePath= Base64Decoder().convert(x.imageP,
 ),
                                 //  height: 200,
                         // width: 420,
                            fit: BoxFit.fill,
                                          )),
                                  Positioned(
                                    bottom: 20,
                                    // right: 10,
                                    child: Container(
                                      width: 300,
                                      color: Colors.black54,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        x.packageName,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.schedule,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text('2 days'),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(x.NumOfPax + ' Min pax'),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.attach_money,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text('RM ' + x.packagePrice),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  }))
    ]));
    //                   })),
    //     ],
    //   ),
    // );
  }
}

// ///body: Center(
// // child: const Text('Press the button below!')
// // ),
// // floatingActionButton: FloatingActionButton(
// // onPressed: () {

// //Navigator.of(context).push(
// //MaterialPageRoute(builder: (context) =>  AddProduct()));

// // Add your onPressed code here!
// // },
// //child: Icon(Icons.navigation),
// // backgroundColor: Colors.green,
// //),
// //);
