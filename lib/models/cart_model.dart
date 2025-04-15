import 'package:flutter/material.dart';
import 'drink.dart';

class CartModel extends ChangeNotifier {
  final List<Drink> _cartItems = [];

  List<Drink> get cartItems => _cartItems;

  void addToCart(Drink drink) {
    _cartItems.add(drink);
    notifyListeners();
  }

  void removeFromCart(Drink drink) {
    _cartItems.remove(drink);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }
}
