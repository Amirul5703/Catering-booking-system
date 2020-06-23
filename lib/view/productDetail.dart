import 'package:flutter/material.dart';
import 'package:test_1/model/getpackage.dart';
import 'package:test_1/model/productModel.dart';
import '../widget/PackagePage.dart';
import '../widget/aboutPage.dart';
import 'dart:convert';

import 'dart:typed_data';
//import '../model/getpackage.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel model;

  DetailProduct(this.model);
  
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct>
    with SingleTickerProviderStateMixin {
  List<Choice> tabs = [];
  TabController mTabController;
  int mCurrentPosition = 0;
  
Uint8List _imagePath; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                new SliverAppBar(
                    floating: false,
                    pinned: true,
                      elevation: 50,
                    expandedHeight: 260.0,
                    backgroundColor: Colors.orangeAccent[100],
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(widget.model.CatererName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                        background: Stack(children: <Widget>[
                          Hero(
                            tag: widget.model.CatererId,
                            child: Image.memory(
                                _imagePath= Base64Decoder().convert(widget.model.image_url,
                                
                                
                                
                                ),
                                   height: 290,
                          width: 420,
                           fit: BoxFit.fill,
                                
                                ),
                          ),
                          Positioned(
                            left: 0.0,
                            bottom: 0.0,
                            width: 500.0,
                            height: 290.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                   Colors.orange[100],
                                    Colors.black12,
                                    Colors.black12,
                                  ])),
                            ),
                          ),
                        ]))
                        
                        
                        ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.orangeAccent,
                      labelColor: Colors.orangeAccent,
                      unselectedLabelColor: Colors.black45,
                      tabs: tabs.map((Choice choice) {
                        return new Tab(
                          text: choice.title,
                          icon: new Icon(
                            choice.icon,
                          ),
                        );
                      }).toList(),
                      controller: mTabController,
                    ),
                  ),
                )
              ];
            },
            body: new TabBarView(
              children: tabs.map((Choice choice) {
                return new Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ListView(
                      children: <Widget>[
                        choice.position == 0
                            ? new Container(
                                child: PokemonAbout(widget.model.desc,widget.model.email,widget.model.phoneNum, double.parse(widget.model.rating))
                              )
                            : Container(
                                child: PackagePage(widget.model.CatererId)
                                ,

                                //Text(widget.model.nameP),
                              ),
                      ],
                    ));
              }).toList(),
              controller: mTabController,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabs.add(
        Choice(title: 'About', icon: Icons.restaurant_menu, position: 0));

    tabs.add(Choice(title: 'Package', icon: Icons.info_outline, position: 1));

    mTabController = new TabController(vsync: this, length: tabs.length);

    //Determine whether the TabBar switches
    mTabController.addListener(() {
      if (mTabController.indexIsChanging) {
        setState(() {
          mCurrentPosition = mTabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }
}

class Choice {
  const Choice({this.title, this.icon, this.position});
  final String title;
  final int position;
  final IconData icon;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
