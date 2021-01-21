import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../pages/product_details_page.dart';
import "../pages/products_page.dart";
import '../providers/product_provider.dart';
import '../pages/cart_page.dart';
import '../pages/product_edit_page.dart';
import '../pages/add_product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            accentColor: Colors.deepOrange,
          ),
          routes: {
            '/': (ctx) => ProductPage(),
            ProductDetail.pageRoute: (ctx) => ProductDetail(),
            CartPage.routeName: (ctx) => CartPage(),
            ProductEdit.routeName: (ctx) => ProductEdit(),
            AddProduct.routeName: (ctx) => AddProduct(),
          },
        ));
  }
}
