import 'package:alkhalafsheep/UI/product/product_controller.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleProductVertical extends StatelessWidget {
  final Product? product;

  SingleProductVertical({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor,
              offset: Offset(0, 0),
              blurRadius: 8,
              spreadRadius: 2,
            )
          ]),
      // padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductController.id, arguments: product);
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: product!.images != null && product!.images!.length > 0
                      ? product!.images![0]
                      : '',
                  fit: BoxFit.cover,
                  errorWidget: (a,s,d){
                    return Image.asset(
                      'assets/img/holder.png',
                      fit: BoxFit.fill,
                      height: 140,
                    );
                  },
                  placeholder: (ctx, url) {
                    return Image.asset(
                      'assets/img/logo_white_bk.png',
                      fit: BoxFit.fill,
                      height: 140,
                    );
                  },
                ),
              ),
            ),
            //Title
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Text(
                      product!.title!,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
