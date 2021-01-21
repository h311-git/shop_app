import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  CartItem({this.id, this.productId, this.title, this.quantity, this.price});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeCart(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are You Sure?"),
                  content: Text("Do you really want to delete this item?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text("Yes"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text("No"),
                    )
                  ],
                ));
      },
      background: Container(
          child: Icon(
            Icons.delete,
            size: 45,
          ),
          padding: EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                child: FittedBox(child: Text('\$$price')),
              ),
              title: Text(title),
              subtitle: Text("\$${price * quantity}"),
              trailing: Text('$quantity x'),
            )),
      ),
    );
  }
}
