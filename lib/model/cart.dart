import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String datetimeEvent;
  final String instruction;
  final String packageName;
  final String personPax;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.datetimeEvent,
    @required this.instruction,
    @required this.packageName,
    @required this.personPax,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;

    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

   double get quantity {
    var total = 0.0;

    _items.forEach((key, cartItem) {
      total +=  cartItem.quantity;
    });
    return total;
  }

  get id {
    var i;

    _items.forEach((key, cartItem) {
      i = cartItem.id;
    });
    return i;
  }

  get title {
    var t;

    _items.forEach((key, cartItem) {
      t = cartItem.title;
    });
    return t;
  }

  get datetimeEvent {
    var d;

    _items.forEach((key, cartItem) {
      d = cartItem.datetimeEvent;
    });
    return d;
  }

  get instruction {
    var l;

    _items.forEach((key, cartItem) {
      l = cartItem.instruction;
    });
    return l;
  }

  get packName {
    var p;

    _items.forEach((key, cartItem) {
      p = cartItem.packageName;
    });
    return p;
  }

  get personPax {
    var a;

    _items.forEach((key, cartItem) {
      a = cartItem.personPax;
    });
    return a;
  }

  void addItem(
    String productId,
    double price,
    String title,
    String datetimeEvent,
    String instruction,
    String packageName,
    String personPax,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            datetimeEvent: existingCartItem.datetimeEvent,
            instruction: existingCartItem.instruction,
            quantity: existingCartItem.quantity + 1,
            packageName: existingCartItem.packageName,
            personPax: existingCartItem.personPax),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          datetimeEvent: datetimeEvent,
          instruction: instruction,
          quantity: 1,
          packageName: packageName,
          personPax: personPax,
          //personPax: personPax,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              datetimeEvent: existingCartItem.datetimeEvent,
              instruction: existingCartItem.instruction,
              quantity: existingCartItem.quantity - 1,
              packageName: existingCartItem.packageName,
              personPax: existingCartItem.personPax));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
