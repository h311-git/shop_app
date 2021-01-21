import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/user_products.dart';
import './add_product_page.dart';

class ProductEdit extends StatelessWidget {
  static const routeName = '/userProducts';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Product"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddProduct.routeName);
              })
        ],
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Column(children: [
              UserProductItem(
                  id: products.items[index].id,
                  imageUrl: products.items[index].imageUrl,
                  title: products.items[index].title),
              Divider(),
            ]);
          },
          itemCount: products.items.length,
        ),
      ),
    );
  }
}
