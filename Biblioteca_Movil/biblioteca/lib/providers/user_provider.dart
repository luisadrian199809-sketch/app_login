import 'package:flutter/material.dart';
import '../models/user.dart';
import '../database/database_helper.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> registerUser(User user) async {
    await DatabaseHelper.instance.insertUser(user);
    _user = user;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    User? loggedUser = await DatabaseHelper.instance.getUser(email, password);
    if (loggedUser != null) {
      _user = loggedUser;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
