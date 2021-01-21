import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/products_items.dart';
import '../providers/product_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavorite;
  ProductsGrid(this.isFavorite);
  @override
  Widget build(BuildContext context) {
    final productsObject = Provider.of<Products>(context, listen: false);
    final products =
        isFavorite ? productsObject.getFavorite : productsObject.items;
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(
              // id: products[index].id,
              // imageUrl: products[index].imageUrl,
              // title: products[index].title,
              ),
        );
      },
      itemCount: products.length,
    );
  }
}
