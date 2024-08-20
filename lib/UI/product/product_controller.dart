// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:alkhalafsheep/UI/cart_provider/cart_provider_controller.dart';
import 'package:alkhalafsheep/elements/alerts.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

class ProductController extends StatefulWidget {
  static const String id = 'product';
  final Product? product;

  ProductController({required this.product});

  @override
  _ProductControllerState createState() => _ProductControllerState();
}
class _ProductControllerState extends State<ProductController> {
  List<Option?> cartOptions = [];

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: true);
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                '${widget.product!.title}',
                style: kWhiteTextColor,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(CartProviderController.id, arguments: true);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          cartProvider.cart == null ||
                                  cartProvider.cart!.length < 1
                              ? Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 13.0, color: kPrimaryColor),
                                )
                              : CircleAvatar(
                                  radius: 8.6,
                                  backgroundColor: Colors.blueGrey,
                                  child: Text(
                                    '${cartProvider.cart!.length}',
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.white),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
              backgroundColor: kPrimaryColor,
              centerTitle: true),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      if (widget.product!.images != null &&
                          widget.product!.images!.length > 1)
                        CarouselSlider(
                          items: widget.product!.images!.map((image) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          image != null && image.isNotEmpty
                                              ? image
                                              : '',
                                      errorWidget: (vtx, url, obj) {
                                        return Image.asset(
                                          'assets/img/logo_white_bk.png',
                                          fit: BoxFit.cover,
                                          height: 165,
                                        );
                                      },
                                      placeholder: (ctx, url) {
                                        return Image.asset(
                                          'assets/img/logo_white_bk.png',
                                          fit: BoxFit.cover,
                                          height: 165,
                                        );
                                      },
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                          options: CarouselOptions(
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 650),
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            viewportFraction: 1.0,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            height: 165,
                            onPageChanged: (pageNo, reason) {
                              // setState(() {
                              //   _currentPage = pageNo;
                              // });
                            },
                          ),
                        ),
                      if (widget.product!.images != null &&
                          widget.product!.images!.length == 1)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.product!.images != null &&
                                    widget.product!.images!.length > 0
                                ? widget.product!.images![0]
                                : '',
                            fit: BoxFit.cover,
                            height: 120,
                            placeholder: (ctx, url) {
                              return Image.asset(
                                'assets/img/logo_white_bk.png',
                                fit: BoxFit.cover,
                                height: 120,
                              );
                            },
                          ),
                        ),
                      if (widget.product!.title != null &&
                          widget.product!.title!.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            widget.product!.title!,
                            style: kTextBlackBoldHeader,
                          ),
                        ),
                      if (widget.product!.description != null &&
                          widget.product!.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: HtmlWidget(widget.product!.description!),
                        )
                    ],
                  ),
                ),
                ...widget.product!.options!.map((option) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        //option title
                        Container(
                          width: double.infinity,
                          child: Text('${option.title}'),
                        ),

                        if (option.singleOptions!.length > 0)
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.2),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.all(4.0),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: DropdownButton<SingleOption>(
                              value: optionValue(option),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: kPrimaryColor,
                              ),
                              hint: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  option.title!,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              underline: Container(),
                              onChanged: (singleOption) {
                                addToCartOption(singleOption!);
                              },
                              isExpanded: true,
                              items: option.singleOptions!
                                  .map<DropdownMenuItem<SingleOption>>(
                                      (SingleOption value) {
                                return DropdownMenuItem<SingleOption>(
                                  value: value,
                                  onTap: () {
                                    return ;
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: value.status == 1
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${value.title} ',
                                                style: TextStyle(fontSize: 16),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              if (value.price != null &&
                                                  value.price! > 0)
                                                Text(
                                                  ' - ${value.price}ريال ',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                            ],
                                          )
                                        : Text(
                                            '${value.title} نفذت الكمية ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
                GestureDetector(
                  onTap: () {
                    if (calculatePrice() > 0) {
                      CartProduct cartProduct = new CartProduct(
                          id: widget.product!.id,
                          categoryId: widget.product!.categoryId,
                          options: cartOptions,
                          title: widget.product!.title,
                          description: widget.product!.description,
                          images: widget.product!.images);

                      // if (cartProvider.cart != null) {
                      //   cartProvider.cart.forEach((singleCart) {
                      //     if (singleCart.id == cartProduct.id) {
                      //       if (singleCart.options.first.singleOptions.first.id == cartProduct.options.first.singleOptions.first.id
                      //           && singleCart.options.last.singleOptions.first.id == cartProduct.options.last.singleOptions.first.id) {
                      //         doseProductAlreadySaved = true;
                      //       }
                      //     }
                      //   });
                      // }

                      // if (doseProductAlreadySaved) {
                      //   Toast.show('المنتج مضاف مسبقا الي السلة', context,
                      //       duration: Toast.LENGTH_SHORT,
                      //       gravity: Toast.BOTTOM);
                      //   return;
                      // }
                      if (cartProvider.cart == null) cartProvider.cart = [];
                      cartProvider.cart!.add(cartProduct);

                      cartProvider.notifyListeners();
// Toast.show('تم الأضافة بنجاح',gravity: Toast.top,duration: Toast.lengthLong);
                      // Toast.show('تم الأضافة بنجاح', context,
                      //     duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
             Alerts.showToast('تم الأضافة بنجاح');
             Navigator.pushReplacementNamed(context, CartProviderController.id,arguments:true);
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: calculatePrice() > 0 ? kPrimaryColor : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('إضافة الي السلة',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        SizedBox(width: 8),
                        Icon(Icons.add_shopping_cart, color: Colors.white),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SingleOption? optionValue(Option option) {
    List<Option?> op =
        cartOptions.where((element) => element!.id == option.id).toList();

    if (op.length > 0)
      Echo('optionValue ${op.first!.singleOptions!.first.title}');

    return op.length > 0 ? op.first!.singleOptions!.first : null;
  }

  void addToCartOption(SingleOption singleOption) {
    Echo('addToCartOption ${singleOption.title}');

    Option? selectedOption;
    widget.product!.options!.forEach((option) {
      option.singleOptions!.forEach((element) {
        if (element == singleOption) {
          List<SingleOption> list = [];
          list.add(element);
          selectedOption = new Option(
              id: option.id,
              title: option.title,
              isItRequired: option.isItRequired,
              singleOptions: list);
        }
      });
    });
    Echo('cartOptions before remove ${cartOptions.length}');
    cartOptions.removeWhere((element) => element!.id == selectedOption!.id);
    Echo('cartOptions after remove ${cartOptions.length}');
    cartOptions.add(selectedOption);
    Echo(
        'addToCartOption add ${selectedOption!.id} ${selectedOption!.singleOptions!.first.title}');

    setState(() {});
  }

  double calculatePrice() {
    double price = 0;
    cartOptions.forEach((element) {
      if (element!.singleOptions!.first != null &&
          element.singleOptions!.first.price != null &&
          element.singleOptions!.first.price! > -1)
        price += element.singleOptions!.first.price!;
    });

    return price;
  }
}
