import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as eos;
import 'package:numberpicker/numberpicker.dart';
import 'package:test_1/model/menuModel.dart';
import 'package:test_1/model/productModel.dart';
import './mainScreen.dart';
import 'dart:typed_data';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../model/cart.dart';
import 'package:provider/provider.dart';
import '../widget/badge.dart';
import '../pages/cartPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/getpackage.dart';
import '../widget/Alert.dart';

class BuildItem extends StatefulWidget {
  final GetPackage model;

  BuildItem(this.model);

  @override
  _BuildItemState createState() => new _BuildItemState();
}

class _BuildItemState extends State<BuildItem> {
  TextEditingController mycontroller = TextEditingController();
  var loading = false;
  bool isSwitched = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;

  final list = new List<GetMenus>();
  _getData(String id) async {
    list.clear();

    setState(() {
      loading = true;
    });

    final response = await http.get(
        'http://192.168.0.152/1/api/GetMenus.php?PackageId=${widget.model.PackageId}');
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new GetMenus(
          api['PackageId'],
          api['MenuId'],
          api['Menu1'],
          api['Menu2'],
          api['Menu3'],
          api['Menu4'],
          api['Menu5'],
          api['Menu6'],
          api['Menu7'],
          api['Menu8'],
          api['Menu9'],
          api['Menu10'],
          api['Menu11'],
          api['Menu12'],
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

    _getData("PackageId");
  }

  FocusNode myFocusNode;

  // void _onRememberMeChanged(bool value) => setState(() {
  //       isSwitched = value;

  //       if (value = true) {
  //       } else {}
  //     });

  int _currentIntValue = 25;
  int t = 0;
  var textHolder = 'No';

  int t2 = 0;
  var textHolder2 = 'No';

  int t3 = 0;
  var textHolder3 = 'No';
  DateTime date1;
  // price= double.parse('${widget.model.packagePrice}');

  String value = '';

  //int get assetPackage => widget.model.qty;

  NumberPicker integerNumberPicker;

  setup() {
    _currentIntValue = int.parse(widget.model.NumOfPax);
  }

  double get totalCost {
    return _currentIntValue * double.tryParse(widget.model.packagePrice) +
        t +
        t2 +
        t3;
  }

  @override
  Widget build(BuildContext context) {
     Uint8List imagePath;
    final cart = Provider.of<Cart>(context, listen: false);

    final title1 = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              widget.model.CatererName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                fontSize: 20,
              ),
            ),
            Text(
              widget.model.packageName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Row(children: <Widget>[])
      ],
    );

    final title3 = Container(
      width: 340,
      // padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Text(
                '   Price',
                style: TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.w800,
                  //fontFamily: 'Roboto',
                  //letterSpacing: 0.5,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Chip(
                  label: Text(
                    'RM ' + widget.model.packagePrice,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
              ]),
        ],
      ),
    );

    final title4 = Container(
      width: 350,
      // padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '    Number of pax',
                style: TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.w800,
                  //fontFamily: 'Roboto',
                  //letterSpacing: 0.5,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              ActionChip(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                label: Text(
                  "Min: $_currentIntValue",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                onPressed: () => _showIntDialog(),
              ),

              Icon(
                Icons.arrow_forward_ios,
                color: Colors.redAccent,
              )

              // new IconButton(

              //   icon: Icon(
              //     Icons.arrow_forward_ios,
              //     size: 20,color: Colors.red,
              //   ),
              //   onPressed: () => _showIntDialog(),
              // )
            ],
          ),
        ],
      ),
    );

    final total = Container(
      width: 340,
      //padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '  Total Price',
                style: TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.w800,
                  //fontFamily: 'Roboto',
                  //letterSpacing: 0.5,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Chip(
                label: Text(
                  ("RM: $totalCost"),
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.title.color,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ],
      ),
    );

    final descTextStyle = TextStyle(
      color: Colors.black,
      //fontWeight: FontWeight.w800,
      // fontFamily: 'Roboto',
      letterSpacing: 0.5,
      //fontSize: 18,
      height: 1.5,
    );

    final iconListh = DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.kitchen, color: Colors.green[500]),
                Text('PREP:'),
                Text('25 min'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.timer, color: Colors.green[500]),
                Text('COOK:'),
                Text('1 hr'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.restaurant, color: Colors.green[500]),
                Text('FEEDS:'),
                Text("$_currentIntValue"),
              ],
            ),
          ],
        ),
      ),
    );

    final title6 = Container(
        width: 320.0,
        height: 70.0,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(7.0),
            ),
            //Text('Selected value: $date1'),
            //Text(myController.Text),

            TextField(
              // autofocus: false,
              // autocorrect: true,
              //controller: mycontroller,
              onChanged: (text) {
                value = text;
              },

              //dsfobscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add instruction here',
              ),
            ),

            SizedBox(height: 16.0),
          ],
        ));

    final title7 = Container(
        width: 320.0,
        height: 70.0,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(7.0),
            ),
            //Text('Selected value: $date1'),
            //Text(myController.Text),

            DateTimeField(
              onChanged: (dt) {
                setState(() => date1 = dt);
                print('Selected date: $date1');
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Please select date and time',
                hasFloatingPlaceholder: false,
              ),
              format: DateFormat("EEE, d MMM yyyy 'at' h:mma"),
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now().add(Duration(days: 2)),
                    initialDate:
                        currentValue ?? DateTime.now().add(Duration(days: 3)),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            ),

            SizedBox(height: 16.0),
          ],
        ));

    final planetThumbnail = new Container(
      margin: const EdgeInsets.only(top: 0),
      alignment: FractionalOffset.topCenter,
      child:   Container(
                width: 100.0,
                height: 98.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: new MemoryImage(
                        imagePath= Base64Decoder().convert(widget.model.imageP)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
    );

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(child: ch, value: cart.itemCount.toString()),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Build your order',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final x = list[i];

                      return new Container(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                              padding: EdgeInsets.only(
                                  right: 0, bottom: 20, top: 20, left: 0),
                              child: Column(children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Card(
                                      margin: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          bottom: 00,
                                          top: 45),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      elevation: 20,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(27.0),
                                          ),
                                          title1,
                                          title3,
                                          title4,
                                          total,
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    planetThumbnail,
                                  ],
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('        Buffet line setup'),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8)),
                                            MyApp(),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 100)),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Switch(
                                                        //value: isSwitched,
                                                        onChanged: (bool e) =>
                                                            change(),
                                                        value: isSwitched,

                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                      Text(textHolder, style: TextStyle(color: Colors.blueAccent))
                                                    ],
                                                  ),
                                                ]),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('        Melamine cultlery'),
                                            MyApp(),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 100)),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Switch(
                                                        //value: isSwitched,
                                                        onChanged: (bool e) =>
                                                            change2(),
                                                        value: isSwitched2,

                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                      Text(textHolder2, style: TextStyle(color: Colors.blueAccent))
                                                    ],
                                                  ),
                                                ]),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('        Helpers'),
                                             Padding(
                                                padding:
                                                    EdgeInsets.only(right: 62)),
                                            MyApp(),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 100)),
                                                    
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                 
                                                  Row(
                                                    children: [
                                                      Switch(
                                                        //value: isSwitched,
                                                        onChanged: (bool e) =>
                                                            change3(),
                                                        value: isSwitched3,

                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                      Text(textHolder3, style: TextStyle(color: Colors.blueAccent))
                                                    ],
                                                  ),
                                                ]),
                                          ]),
                                    ],
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 20,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      // Icon(Icons.list,
                                      //     color: Colors.green[500]),

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 9),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Icon(Icons.fastfood,
                                              color: Colors.green[500]),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Text(x.Menu2),
                                              ]),
                                          Column(
                                            children: [
                                              Icon(Icons.list,
                                                  color: Colors.green[500]),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 9),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(x.Menu2),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(x.Menu2),
                                              ]),
                                          Column(
                                            children: [
                                              // Padding(
                                              //   padding:
                                              //       EdgeInsets.only(bottom: 19),
                                              // ),
                                              //Text(x.Menu1),
                                              Text(x.Menu2),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 9),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(x.Menu2),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(x.Menu2),
                                              ]),
                                          Column(
                                            children: [
                                              // Padding(
                                              //   padding:
                                              //       EdgeInsets.only(bottom: 19),
                                              // ),
                                              //Text(x.Menu1),
                                              Text(x.Menu2),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 9),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(x.Menu2),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(x.Menu2),
                                              ]),
                                          Column(
                                            children: [
                                              // Padding(
                                              //   padding:
                                              //       EdgeInsets.only(bottom: 19),
                                              // ),
                                              //Text(x.Menu1),
                                              Text(x.Menu2),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 19),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.list,
                                          color: Colors.green[500]),
                                      Column(
                                        children: <Widget>[
                                          title6,
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.timer,
                                          color: Colors.green[500]),
                                      Column(
                                        children: <Widget>[title7],
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 20,
                                  child: Column(
                                    children: <Widget>[
                                      //title
                                      // title51
                                    ],
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 20,
                                      top: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.white,
                                  elevation: 20,
                                  child: Column(
                                    children: <Widget>[
                                      iconListh,
                                    ],
                                  ),
                                ),
                                ButtonTheme(
                                  splashColor: Colors.red,
                                  minWidth: 500.0,
                                  height: 50.0,
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 20,
                                        top: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        cart.addItem(
                                            widget.model.PackageId,
                                            double.parse("$totalCost"),
                                            widget.model.CatererName,
                                            '$date1',
                                            value,
                                            widget.model.packageName,
                                            "$_currentIntValue");
                                        Scaffold.of(context)
                                          ..hideCurrentSnackBar();

                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Added item to cart!',
                                            ),
                                            duration: Duration(seconds: 2),
                                            action: SnackBarAction(
                                              label: 'UNDO',
                                              onPressed: () {
                                                cart.removeSingleItem(
                                                    widget.model.PackageId);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.card_travel,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            'ADD TO BAG',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),

                                      //elevation: 20,
                                    ),
                                  ),
                                )
                              ])));
                    })));
  }

  void change() {
    setState(() {
      if (isSwitched) {
        textHolder = 'No';
        t = 0;
        isSwitched = !isSwitched;
      } else {
        t = 100;
        textHolder = 'Yes';
        isSwitched = !isSwitched;
      }
    });
  }

  void change2() {
    setState(() {
      if (isSwitched2) {
        textHolder2 = 'No';
        t2 = 0;
        isSwitched2 = !isSwitched2;
      } else {
        t2 = 10;
        textHolder2 = 'Yes';
        isSwitched2 = !isSwitched2;
      }
    });
  }

  void change3() {
    setState(() {
      if (isSwitched3) {
        textHolder3 = 'No';
        t3 = 0;
        isSwitched3 = !isSwitched3;
      } else {
        t3 = 20;
        textHolder3 = 'Yes';
        isSwitched3 = !isSwitched3;
      }
    });
  }

  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            child: NumberPickerDialog.integer(
          title: new Text(
            "How many guest will be attending?",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.redAccent),
          ),
          minValue: 1,
          maxValue: 100,
          step: 1,
          initialIntegerValue: _currentIntValue,
        ));
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _currentIntValue = value);
        integerNumberPicker.animateInt(value);
      }
    });
  }
}
