import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../pages/product_details_page.dart';
import "../pages/products_page.dart";
import '../providers/product_provider.dart';
import '../pages/cart_page.dart';
import '../pages/product_edit_page.dart';
import '../pages/add_product_page.dart';
import '../pages/login_page.dart';
import '../providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProvider(create: (ctx) => Auth()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              accentColor: Colors.deepOrange,
            ),
            routes: {
              '/': (ctx) => auth.isauth()
                  ? ProductPage()
                  : FutureBuilder(
                      future: auth.autoLogin(),
                      builder: (ctx, dataSnapshot) =>
                          dataSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? CircularProgressIndicator()
                              : LoginPage()),
              ProductPage.routeName: (ctx) => ProductPage(),
              ProductDetail.pageRoute: (ctx) => ProductDetail(),
              CartPage.routeName: (ctx) => CartPage(),
              ProductEdit.routeName: (ctx) => ProductEdit(),
              AddProduct.routeName: (ctx) => AddProduct(),
            },
          ),
        ));
  }
}
