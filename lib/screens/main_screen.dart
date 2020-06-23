import 'package:flutter/material.dart';
import 'package:test_1/model/productModel.dart';
import '../pages/favoritePage.dart';
import '../pages/MainPage.dart';
import '../pages/profilePage.dart';
import '../pages/cartPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/badge.dart';
import '../model/cart.dart';
import 'package:provider/provider.dart';



class MainScreen extends StatefulWidget {


  final VoidCallback signOut;

  MainScreen(this.signOut);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  signOut() { 
    setState(() {
      widget.signOut();
    });
  }

String username = '', nama = '';
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('username');
      nama = preferences.getString('nama');
    });
  }

  @override                      
 void initState() {             
 super.initState();
  getPref();
  }


  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
      length: 4,
      child: 
        Scaffold(

      body: TabBarView(
        
            children: <Widget>[
              HomePage(),
              FavoritePage(),
                 CartScreen (),
                 OrdersScreen(),
              
            
             
              //signOut(),
            ],
          ),
          
          
          
          bottomNavigationBar: TabBar(

                      indicatorColor: Colors.deepOrangeAccent[200],
 indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.deepOrangeAccent[200],
                      unselectedLabelColor: Colors.black45,

            // labelColor: Colors.blue,
            // unselectedLabelColor: Colors.blueGrey,
            // indicator: UnderlineTabIndicator(
            //   borderSide: BorderSide(style: BorderStyle.none 
            tabs: <Widget>[
              Tab(
                
                   icon: Icon(Icons.home, size: 30,),
               
              ),
              Tab(
               
                 icon: Icon(Icons.list, size: 30,),
              ),
              Tab( child:

                 Consumer <Cart>(builder: (_, cart, ch) => Badge(
                 child: ch,
                 value: cart.itemCount.toString()
               ),
               child: IconButton(
                   icon: Icon(Icons.shopping_cart, size: 30,),
                   onPressed: (){

                      Navigator.of(context).pushNamed(CartScreen.routeName);
                   },
                 ),
               
               ),
              
              ),
              Tab(
              
                 icon: Icon(Icons.person, size: 30,),
              ),
            
            ],
          ),
        )
    );
  }
}












 