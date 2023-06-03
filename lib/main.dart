import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../Providers/orders.dart';
import '../screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './Providers/products_provider.dart';
import './Providers/cart.dart';
import './screens/orders_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //The ChangeNotifierProvider is a widget that makes us listen whenever that class updates only the child widget will rebuid
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          //if we use ChangeNotifierProvider() widget and need
          //create: (context) => Products(),

          //or use ChangeNotifierProvider.value() and the value attribute we use this shortcut
          //because we don't need the context argument of the function we were creating using ChangeNotifierProvider() widget
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop app',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          colorScheme: const ColorScheme.light(
              primary: Colors.purpleAccent, onSecondary: Colors.deepOrange),
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge:
                    const TextStyle(color: Color.fromRGBO(25, 51, 51, 1)),
                bodySmall:
                    const TextStyle(color: Color.fromRGBO(25, 51, 51, 1)),
                titleLarge: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'lato',
                  fontWeight: FontWeight.bold,
                ),
                titleMedium: const TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontSize: 21.0,
                ),
              ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
        },
      ),
    );
  }
}
