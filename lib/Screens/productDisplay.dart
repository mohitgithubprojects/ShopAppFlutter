import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/21.1%20badge.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/Widgets/productwidget.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/productsProvider.dart';

import 'cartScreen.dart';

enum FilterOptions { Favorites, All }

class ProductDisplay extends StatefulWidget {
  static const routeName = '/ProductDisplay';

  final String title;

  ProductDisplay(this.title);

  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  bool _showOnlyFavs = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Consumer<Cart>(
            builder: (ctx, cartContainer, child) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              value: cartContainer.itemCount.toString(),
              color: Colors.red,
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  _showOnlyFavs = true;
                } else {
                  _showOnlyFavs = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Only Favorites',
                ),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text(
                  'Show All',
                ),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (ctx, productProvider, child) {
          return _showOnlyFavs
              ? GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (ctx, pos) => ChangeNotifierProvider.value(
                      value: productProvider.favItems[pos],
                      child: ProductWidget()),
                  itemCount: productProvider.favItems.length,
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (ctx, pos) => ChangeNotifierProvider.value(
                      value: productProvider.items[pos],
                      child: ProductWidget()),
                  itemCount: productProvider.items.length,
                );
        },
      ),
    );
  }
}
