import 'package:alkhalafsheep/UI/checkout/shipping_address.dart';
import 'package:alkhalafsheep/UI/login/login_controller.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CartProviderController extends StatefulWidget {
  static const String id = 'cart';
  final bool? showAppBar;

  CartProviderController({this.showAppBar = true});

  @override
  _CartProviderControllerState createState() => _CartProviderControllerState();
}

class _CartProviderControllerState extends State<CartProviderController> {
  List<CartProduct>? cartProducts;
  bool loading = true;
  late CartProvider cartProvider;

  @override
  void initState() {
    super.initState();
  }

  void deleteCartProductDb(cartProductModel) async {
    cartProducts!.remove(cartProductModel);
    cartProvider.notifyListeners();

    setState(() {});
  }

  void editCartProductDb(cartProductModel) async {}

  double calculateProductPricePrice(CartProduct cartProduct) {
    double price = 0;
    cartProduct.options!.forEach((element) {
      if (element!.singleOptions!.first != null &&
          element.singleOptions!.first.price != null &&
          element.singleOptions!.first.price! > -1)
        price += element.singleOptions!.first.price!;
    });

    return price * cartProduct.qty;
  }

  double calculateTotal() {
    double total = 0;
    cartProducts!.forEach((element) {
      total += calculateProductPricePrice(element);
    });
    return total;
  }




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProducts = cartProvider.cart;
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: !widget.showAppBar!
              ? null
              : AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  centerTitle: true,
                  backgroundColor: kPrimaryColor,
                  title: Text(YemString.cart, style: kWhiteTextColor),
                ),
          body:  cartProducts!.length > 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 26),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ...cartProducts!.map((singleProduct) {
                                        return Card(
                                          margin: EdgeInsets.all(8),
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Container(
                                            margin: EdgeInsets.all(4),
                                            child: Row(children: <Widget>[
                                              //product image
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        120.0),
                                                child: CachedNetworkImage(
                                                  height: 90,
                                                  width: 90,
                                                  imageUrl: singleProduct
                                                                  .images !=
                                                              null &&
                                                          singleProduct.images!
                                                                  .length >
                                                              0
                                                      ? singleProduct.images![0]
                                                      : '',
                                                  fit: BoxFit.cover,
                                                  placeholder: (ctx, url) {
                                                    return Image.asset(
                                                      'assets/img/logo_white_bk.png',
                                                      fit: BoxFit.cover,
                                                      height: 110,
                                                      width: 110,
                                                    );
                                                  },
                                                ),
                                              ),

                                              // Name , price , quantity
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          AutoSizeText(
                                                            singleProduct.title!,
                                                            style:
                                                                kTextBlackBoldBody,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              InkWell(
                                                                onTap: () {
                                                                  deleteCartProductDb(
                                                                      singleProduct);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              4),
                                                                  child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .redAccent),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    //Original Price

                                                    //Note
                                                    if (singleProduct.note !=
                                                            null &&
                                                        singleProduct.note !=
                                                            '')
                                                      singleRowText(
                                                          YemString.note,
                                                          '${singleProduct.note}',
                                                          null,
                                                          width),

                                                    //price
                                                    SizedBox(height: 8),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            'السعر',
                                                            style:
                                                                kTextGreyBody,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                          Container(
                                                            child: Text(
                                                                '${calculateProductPricePrice(singleProduct)} ريال'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    ...singleProduct.options!
                                                        .map((e) {
                                                      return Column(
                                                        children: [
                                                          SizedBox(height: 8),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  e!.title!,
                                                                  style:
                                                                      kTextGreyBody,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                                SizedBox(
                                                                    width: 8),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Expanded(
                                                                            child:
                                                                                Text(
                                                                          '${e.singleOptions!.first.title}',
                                                                          maxLines:
                                                                              2,
                                                                        )),

                                                                        //  if(e.singleOptions.first.price !=null && e.singleOptions.first.price >0)
                                                                        //     Text('(${e.singleOptions.first.price} ريال)' ,style: TextStyle(color: Colors.black,fontSize: 12),),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }).toList(),

                                                    //quantity
                                                    SizedBox(height: 8),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            YemString.quantity,
                                                            style:
                                                                kTextGreyBody,
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: <Widget>[
                                                              /// Decrease of value item
                                                              InkWell(
                                                                onTap: () {
                                                                  if (singleProduct
                                                                          .qty !=
                                                                      null) if (singleProduct
                                                                          .qty >
                                                                      1) {
                                                                    singleProduct
                                                                        .qty--;
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  decoration: BoxDecoration(
                                                                      border: Border(
                                                                          right:
                                                                              BorderSide(color: Colors.black12.withOpacity(0.1)))),
                                                                  child: Center(
                                                                      child: Text(
                                                                          "-")),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        18.0),
                                                                child:
                                                                    Container(
                                                                  child: Text(
                                                                      singleProduct
                                                                          .qty
                                                                          .toString()),
                                                                ),
                                                              ),

                                                              /// Increasing value of item
                                                              InkWell(
                                                                onTap: () {
                                                                  singleProduct
                                                                      .qty++;
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30.0,
                                                                  width: 28.0,
                                                                  decoration: BoxDecoration(
                                                                      border: Border(
                                                                          left:
                                                                              BorderSide(color: Colors.black12.withOpacity(0.1)))),
                                                                  child: Center(
                                                                      child: Text(
                                                                          "+")),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          NoteEditText(),
                          continueBtn(),
                        ],
                      ),
                    )
                  : NoItemCart()),
       
      ),
    );
  }

  Widget singleRowText(String title, String text, int? price, double width) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
                flex: 2,
                child: Text(title,
                    style: TextStyle(color: Colors.black54, fontSize: 13))),
            Flexible(
              flex: 3,
              child: Container(
//                width: width / 2.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        '$text${price != null && price != 0 ? " ($price ر.س )" : ""}',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget continueBtn() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 2),
                Text('المجموع الكلي :  '),
                SizedBox(width: 20),
                Text(
                  '${calculateTotal()} ر.س',
                  style: TextStyle(color: kPrimaryColor, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 2),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            YemenyPrefs prefs = YemenyPrefs();
            String? token = await prefs.getToken();
            bool userRegistered = token == null || token.isEmpty ? false : true;

            if (userRegistered) {
              Navigator.of(context).pushNamed(ShippingAddress.id);
            } else {
              AwesomeDialog(
                context: context,
                animType: AnimType.scale,
                dialogType: DialogType.info,
                title: YemString.note,
                desc: YemString.required_login,
                btnOkText: YemString.register,
                btnOkOnPress: () {
                  Navigator.pushNamed(context, LoginController.id);
                },
              ).show();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey, width: 0.8),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  'المتابعة',
                  style: TextStyle(color: Colors.white),
                ))),
          ),
        ),
      ],
    );
  }

  void navigateToCheckout(BuildContext context, double total,
      List<CartProduct> cartProducts) async {
    YemenyPrefs prefs = YemenyPrefs();

    bool userRegistered = await prefs.getToken() == null ? false : true;

    if (userRegistered) {
      //todo check navigator
      // Navigator.of(context).push(SwipeablePageRoute(
      //   builder: (BuildContext context) => ShippingAddress(
      //     total: total,
      //     cartProducts: cartProducts,
      //   ),
      // ));
//      Navigator.push(
//        context,
//        PageRouteBuilder(
//          pageBuilder: (context, animation1, animation2) => ShippingAddress(
//            total: total,
//            cartProducts: cartProducts,
//            updateCartCount: widget.updateCartCount,
//          ),
//          transitionsBuilder: (context, animation1, animation2, child) =>
//              FadeTransition(opacity: animation1, child: child),
//          transitionDuration: Duration(milliseconds: 600),
//        ),
//      );
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
        title: YemString.note,
        desc: YemString.required_login,
        btnOkText: YemString.register,
        btnOkOnPress: () {
          Navigator.pushReplacementNamed(context, LoginController.id);
        },
      ).show();
    }
  }
}

class NoItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Column(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Image.asset(
                      'assets/img/ic_empty.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                Text(
                  YemString.empty,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.5,
                      color: Colors.black26.withOpacity(0.2)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NoteEditText extends StatefulWidget {
  @override
  _NoteEditTextState createState() => _NoteEditTextState();
}

class _NoteEditTextState extends State<NoteEditText> {
  late CartProvider cartProvider;
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    _noteController.text = cartProvider.note != null ? cartProvider.note! : '';
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.4),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: YemString.note,
            labelText: YemString.note),
        minLines: 1,
        maxLines: 2,
        controller: _noteController,
        onChanged: (String text) {
          cartProvider.note = _noteController.text.trim();
        },
      ),
    );
  }
}
