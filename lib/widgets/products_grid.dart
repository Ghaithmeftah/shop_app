import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../Providers/products_provider.dart';
import '../Providers/product.dart';
import '../widgets/Product_Item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //we do not need the context argument so we use ChangeNotifierProvider.value(value: ... ) instead of ChangeNotifierProvider(create:...)
        //create: (c) => products[i],
        value: products[i],
        child: ProductItem(),
      ),
    );
  }
}
