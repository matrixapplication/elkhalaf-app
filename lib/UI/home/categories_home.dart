import 'package:alkhalafsheep/UI/products/products_controller.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';

class CategoriesHome extends StatefulWidget {
  @override
  _CategoriesHomeState createState() => _CategoriesHomeState();
}

class _CategoriesHomeState extends State<CategoriesHome> {
  @override
  Widget build(BuildContext context) {
    MainDataProvider data = Provider.of<MainDataProvider>(context, listen: false);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),

          //category title
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
                    'الاقسام',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              )
            ],
          ),

          //Categories as image an name
          Container(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  primary: false,
                  children: [
                    ...data.mainData!.categories!.map((singleCategory) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ProductsController.id, arguments: data.mainData!.products!.where((element) => element.categoryId == singleCategory.id).toList());
                        },
                        child: Card(
                          elevation: 2,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: CachedNetworkImage(
                                  width: MediaQuery.of(context).size.width / 3,
                                  imageUrl: singleCategory.image != null && singleCategory.image!.isNotEmpty ? singleCategory.image! : '',
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
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text(
                                    singleCategory.title!,
                                    style: kTextBlackBody,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
