import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../pages/add_product_page.dart';
import '../providers/product_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  UserProductItem({this.id, this.imageUrl, this.title});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AddProduct.routeName,
                  arguments: id,
                );
              },
            ),
            IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                onPressed: () {
                  Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                }),
          ],
        ),
      ),
    );
  }
}
