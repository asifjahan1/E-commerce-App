import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  void toggleFavorite(Product product) {
    if (_cart.contains(product)) {
      for (Product element in _cart) {
        element.quantity++;
      }
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_cart[index].quantity <= 1) {
      return;
    }
    _cart[index].quantity--;
    notifyListeners();
  }

  double totalPrice() {
    double myTotal = 0.0;
    for (Product element in _cart) {
      myTotal += element.price * element.quantity;
    }
    return myTotal;
  }

  void removeProduct(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }

  incrementQtn(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  decrementQtn(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
    }
    notifyListeners();
  }
}
