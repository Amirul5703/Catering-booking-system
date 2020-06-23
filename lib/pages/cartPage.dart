import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/cartItem.dart';
import '../model/cart.dart' show Cart;
//import '../widgets/cart_item.dart';
import '../model/order.dart';
import '../screens/main_screen.dart';




class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
         
        ],
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Your cart item',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\RM ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: 
            
            
            
            ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                    cart.items.values.toList()[i].id,
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].title,
                     cart.items.values.toList()[i].datetimeEvent,
                    cart.items.values.toList()[i].instruction,
                     cart.items.values.toList()[i].packageName,
                     cart.items.values.toList()[i].personPax,

                  ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
 
  var showProgress = false;
 
 
  

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: showProgress ? 
      
      
      CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 ||showProgress)
          ? null
          : () async {
            showProgress = !showProgress; 
            
              setState(() {
                
                showProgress = true;
              });
            await  
              Provider.of<Orders>(context, listen: false).addOrder(
             //widget.cart.quantity,
              widget.cart.items.values.toList(),

             widget.cart.totalAmount,
            

              );
            
            
            
              setState(() {
               showProgress = false;
              });
              widget.cart.clear();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
