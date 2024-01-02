import 'package:flutter/material.dart';
import 'package:alkhalafsheep/elements/empty_error.dart';
import 'package:alkhalafsheep/elements/product_vertical.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:provider/provider.dart';

class ProductsListWidget extends StatelessWidget {
  final List<Product>? products;
  ProductsListWidget({this.products});

  @override
  Widget build(BuildContext context) {

    if(products == null || products!.length <1)
      return EmptyErrorWidget();

    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8,
      childAspectRatio: 1,
      crossAxisCount: 2,
      primary: false,

      children: [
        ...products!.map((product) {
          return SingleProductVertical(product: product,);
        }).toList(),

      ],);
  }
}
