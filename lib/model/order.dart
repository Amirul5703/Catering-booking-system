import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './cart.dart';
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderrs = [];

  List<OrderItem> get orders {
    return [..._orderrs];
  }

  Future<void> fetchAndSetOrders() async {
    const url = 'http://192.168.0.152/1/api/GetOrder.php';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                    datetimeEvent: item['datetimeEvent'],
                    instruction: item['instruction'],
                    packageName: item['packageName'],
                    personPax: item['personPax']),
              )
              .toList(),
        ),
      );
    });
    _orderrs = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> u, double total) async {
    const url = 'http://192.168.0.152/1/api/userOrder.php';

    //final timestamp = new DateTime.now();
    var id = u.map((cp) => cp.id).single;
    var title = u.map((cp) => cp.title).single;
    var quantity = u.map((cp) => cp.quantity).single.toString();
    var price = u.map((cp) => cp.price).single.toString();
    var datetimeEvent = u.map((cp) => cp.datetimeEvent).single;
    var packageName = u.map((cp) => cp.packageName).single;
    var personPax = u.map((cp) => cp.personPax).single;
    var instruction = u.map((cp) => cp.instruction).single;

    final response = await http.post(url,
        body: ({
          'id': id,
          'title': title,
          'quantity': quantity,
          'price': price,
          'datetimeEvent': datetimeEvent,
          'instruction': instruction,
          'packageName': packageName,
          'personPax': personPax,
        }));
    var p = jsonDecode(response.body);
    print(p);

    notifyListeners();
  }
}
