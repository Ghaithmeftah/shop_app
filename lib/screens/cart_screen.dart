import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/cart.dart';
import '../widgets/Cart_Item.dart' as ic;
import '../Providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(children: <Widget>[
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //Spacer() widget take all the space available that can get from the screen and push the other wodgets to the right
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleLarge!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  MaterialButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items().values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                      child: const Text('ORDER NOW'))
                ]),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
          itemCount: cart.items().length,
          itemBuilder: (ctx, i) => ic.CartItem(
            cart.items().values.toList()[i].id,
            //.keys represents the productId passed in order to remove it
            cart.items().keys.toList()[i],
            cart.items().values.toList()[i].price,
            cart.items().values.toList()[i].quantity,
            cart.items().values.toList()[i].title,
          ),
        )),
      ]),
    );
  }
}
