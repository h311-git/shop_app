import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../pages/cart_page.dart';
import '../widgets/drawer.dart';
import '../providers/product_provider.dart';

enum MenuItems { Favorite, All }

class ProductPage extends StatefulWidget {
  static const routeName = '/product_page';
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var _isFavorite = false;
  @override
  // void initState() {
  //   Provider.of<Products>(context, listen: false).getProducts().then((value) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }).catchError((_) {
  //     showDialog<Null>(
  //         context: context,
  //         builder: (ctx) => AlertDialog(
  //               title: Text("Error"),
  //               content: Text("Something went wrong!"),
  //               actions: [
  //                 FlatButton(
  //                   onPressed: () => {Navigator.of(ctx).pop()},
  //                   child: Text("okey"),
  //                 )
  //               ],
  //             )).then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Shop app"),
        actions: [
          PopupMenuButton(
              onSelected: (MenuItems value) {
                setState(() {
                  value == MenuItems.Favorite
                      ? _isFavorite = true
                      : _isFavorite = false;
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(
                        "Show Favorites",
                      ),
                      value: MenuItems.Favorite,
                    ),
                    PopupMenuItem(
                      child: Text(
                        "Show All",
                      ),
                      value: MenuItems.All,
                    ),
                  ]),
          Consumer<Cart>(
            builder: (_, cardItem, ch) {
              return Badge(
                child: ch,
                value: cardItem.itemCount.toString(),
              );
            },
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartPage.routeName);
                }),
          ),
        ],
      ),
      body: ProductsGrid(_isFavorite),
    );
  }
}
