import 'package:flutter/material.dart';
import '../models/book.dart';

class CartProvider extends ChangeNotifier {
  final Map<Book, int> _items = {};

  Map<Book, int> get items => _items;

  List<Book> get cartItems => _items.keys.toList();

  Map<Book, int> get quantities => _items;

  double get totalPrice {
    double total = 0;
    _items.forEach((book, qty) {
      total += book.price * qty;
    });
    return total;
  }

  void addToCart(Book book) {
    if (_items.containsKey(book)) {
      _items[book] = _items[book]! + 1;
    } else {
      _items[book] = 1;
    }
    notifyListeners();
  }

  void removeBook(Book book) {
    if (_items.containsKey(book)) {
      _items.remove(book);
      notifyListeners();
    }
  }

  void increaseQuantity(Book book) {
    if (_items.containsKey(book)) {
      _items[book] = _items[book]! + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(Book book) {
    if (_items.containsKey(book) && _items[book]! > 1) {
      _items[book] = _items[book]! - 1;
    } else {
      _items.remove(book);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
