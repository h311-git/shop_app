import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _email;
  String _password;
  String _token;

  Future<void> _authenticate(String email, String password, String _url) async {
    final response = await http.post(_url,
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 400) {
      return false;
    }
    final _data = json.decode(response.body);
    _email = email;
    _password = password;
    _token = _data['token'];
    final shpref = await SharedPreferences.getInstance();
    final _uesrData =
        json.encode({'email': _email, 'password': _password, 'token': _token});
    shpref.setString('userCred', _uesrData);
    notifyListeners();
    return true;
  }

  Future<void> signUp(String email, String password) async {
    final _url = "http://10.0.2.2:3000/users";
    _authenticate(email, password, _url);
  }

  Future<void> login(String email, String password) async {
    final _url = "http://10.0.2.2:3000/users/login";
    _authenticate(email, password, _url);
  }

  bool isauth() {
    return _token != null;
  }

  void logout() async {
    _email = null;
    _token = null;
    _password = null;
    final _shpref = await SharedPreferences.getInstance();
    _shpref.remove('userCred');
    notifyListeners();
  }

  Future<bool> autoLogin() async {
    final shpref = await SharedPreferences.getInstance();

    if (!shpref.containsKey('userCred')) {
      return false;
    }
    final _userCred =
        json.decode(shpref.getString('userCred')) as Map<String, Object>;
    _email = _userCred['email'];
    _password = _userCred['password'];
    _token = _userCred['token'];
    notifyListeners();
    return true;
  }
}
