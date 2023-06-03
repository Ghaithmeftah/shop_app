import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/cart.dart';
import '../Providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  //final String id;
  //final String title;
  //final double price;
  //final String ImageUrl;

  //ProductItem(this.id, this.title, this.ImageUrl, this.price);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    //we're not interested in changes for Cart so we add the << listen:false  >> attribute
    final cart = Provider.of<Cart>(context, listen: false);

    print('product rebuild');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(product.title, textAlign: TextAlign.center),
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            onPressed: () {
              product.toggleFavoriteStatus();
            },
          ),
          //Consumer is only wrapped on IconButton because it is the only part that we needs it's changes or updates
          //I'm interested in cahnges only here
          trailing: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
