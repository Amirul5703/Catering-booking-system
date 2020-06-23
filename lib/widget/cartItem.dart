import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String datetimeEvent;
  final String instruction;
  final String packageName;
  final String personPax;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title,
      this.datetimeEvent, this.instruction, this.packageName, this.personPax);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: <Widget>[
              
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
               radius: 30.0,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('$quantity x'),
                ),
              ),
            ),
            title:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                    Container(
                  height: 3.0,
                ),
                 Text(title),
                
            
                 Container(
                  height: 3.0,
                ),
                 Text('Package : $packageName'),
                
                Container(
                  height: 3.0,
                ),
              Text('Total: \RM${(price * quantity)}'),
                Container(
                  height: 3.0,
                ),
                Text('Total person : $personPax'),
                Container(
                  height: 3.0,
                ),
                Text('Total person : $instruction'),
              ],
            ),

            //

            //trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
