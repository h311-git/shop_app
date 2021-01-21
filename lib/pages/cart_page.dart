import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 4,
            shadowColor: Colors.yellowAccent,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Consumer<Cart>(
                      builder: (_, cartItem, ch) {
                        return Text('\$${cartItem.totalQuntity}');
                      },
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Order Now",
                        style:
                            TextStyle(fontSize: 18, color: Colors.deepOrange),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: Consumer<Cart>(
            builder: (_, cartItem, __) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return CartItem(
                    id: cartItem.items.values.toList()[index].id,
                    productId: cartItem.items.keys.toList()[index],
                    title: cartItem.items.values.toList()[index].title,
                    quantity: cartItem.items.values.toList()[index].quantity,
                    price: cartItem.items.values.toList()[index].price,
                  );
                },
                itemCount: cartItem.itemCount,
              );
            },
          ))
        ],
      ),
    );
  }
}
