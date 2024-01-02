import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/product/product_controller.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';

class SingleProductHorizontal extends StatelessWidget {
  final Product? product;

  SingleProductHorizontal(
      {this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ProductController.id,arguments:product );

        },
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: <Widget>[
              //product image
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120.0),
                    child: CachedNetworkImage(
                      height: 120,
                      imageUrl: product!.images != null  &&  product!.images!.length>0 ?  product!.images![0] : '',
                      fit: BoxFit.cover,
                      placeholder: (ctx, url) {
                        return Image.asset(
                          'assets/img/logo_white_bk.png',
                          fit: BoxFit.cover,
                          height: 140,
                        );
                      },
                    ),
                  ),
                ),
              ),
              //Product name ,weight , discount and button
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //product name
                              Text(
                                product!.title!,
                                style: kTextBlackBoldBody,
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
