import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';
import '../data/dummy_products.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummy_products;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get getFavorite {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findByID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product newProduct) {
    const url = 'http://192.168.1.101:3000/products';
    return http.post(url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
        }),
        headers: {'Content-Type': 'application/json'}).then((value) {
      _items.add(Product(
        id: json.decode(value.body)['id'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
      ));
      notifyListeners();
    });
  }

  Future<void> getProducts() async {
    const url = 'http://192.168.1.101:300/products';
    final response = await http.get(url);
    print(json.decode(response.body));
  }

  void updateProduct(String id, Product newProduct) {
    int index = _items.indexWhere((element) => element.id == id);
    _items[index] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
