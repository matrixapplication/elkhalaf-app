import 'package:alkhalafsheep/UI/product/product_controller.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class SpecialProductsOffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainDataProvider data = Provider.of<MainDataProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 12),
          //Title
          Stack(
            children: [
              Image.asset('assets/img/title_bk.png'),
              Positioned(
                top: 0,
                bottom: 0,
                left: 20,
                right: 20,
                child: Center(
                  child: Text(
                    YemString.specialOffers,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              ...data.mainData!.products!.map((product) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProductController.id, arguments: product);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width * 0.35,
                            imageUrl: product.images != null && product.images!.length > 0 ? product.images![0] : '',
                            fit: BoxFit.fill,
                            placeholder: (ctx, url) {
                              return Center(
                                child: Image.asset(
                                  'assets/img/logo_white_bk.png',
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                product.title!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          )
          // Container(
          //   child:
          //   GridView.count(
          //     shrinkWrap: true,
          //     crossAxisSpacing: 8.0,
          //     mainAxisSpacing: 8,
          //     childAspectRatio: 1,
          //     crossAxisCount: 2,
          //     primary: false,
          //     children: [
          //       ...data.mainData.products.map((product) {
          //         return SingleProductVertical(
          //           product: product,
          //         );
          //       }).toList(),
          //     ],
          //   )

          // ),
        ],
      ),
    );
  }
}
