import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
    this.id,
    this.title,
    this.price,
    this.quantity,
  );
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> items() {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //change the quantity ...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            existingCartItem.id,
            existingCartItem.title,
            existingCartItem.price,
            existingCartItem.quantity + 1),
      );
      notifyListeners();
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                DateTime.now().toString(),
                title,
                price,
                1,
              ));
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
