import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/productsProvider.dart';

class ProductDeatilScreen extends StatelessWidget {
  static const routeName = '/ProductDetailScreen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    final product = Provider.of<ProductProvider>(context, listen: false )
        .findById(productId); // listen false means it will not listen to any changes in the provider.

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
