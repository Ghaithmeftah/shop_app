import 'package:flutter/material.dart';
import '../Providers/cart.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyShop'),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOptions.Favorites) {
                      _showOnlyFavorites = true;
                    } else {
                      _showOnlyFavorites = false;
                    }
                  });
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                      PopupMenuItem(
                        value: FilterOptions.Favorites,
                        child: Text(
                          'Only Favorites',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      PopupMenuItem(
                        value: FilterOptions.All,
                        child: Text(
                          'Show ALL',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ]),
            Consumer<Cart>(
              builder: (_, cartData, ch) => badge(
                ch!,
                cartData.itemCount.toString(),
                Theme.of(context).accentColor,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                  )),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: ProductsGrid(_showOnlyFavorites));
  }
}
