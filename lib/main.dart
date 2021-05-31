import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Screens/productDetailScreen.dart';
import 'package:shop_app/Screens/productDisplay.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/productsProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductDisplay('Shop App'),
        routes: {
          ProductDeatilScreen.routeName: (ctx) => ProductDeatilScreen(),
        },
      ),
    );
  }
}
