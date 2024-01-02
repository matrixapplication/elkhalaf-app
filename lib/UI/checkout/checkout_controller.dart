import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/checkout/success_create_order_view.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network/create_order_request.dart';
import 'package:alkhalafsheep/network_models/checkout_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:toast/toast.dart';

class CheckoutController extends StatefulWidget {
  static const String id = 'checkout';
  final CheckoutResponse? checkoutResponse;

  CheckoutController({this.checkoutResponse});

  @override
  _CheckoutControllerState createState() => _CheckoutControllerState();
}

class _CheckoutControllerState extends State<CheckoutController> {
  bool createOrderLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(YemString.checkout, style: kWhiteTextColor),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),

                //invoice
                Column(
                  children: [
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('الفاتورة', style: kTextPrimaryHeader)),
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                blurRadius: 3)
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.checkoutResponse!.data!.total} ر.س',
                                style: kTextGreyBody,
                              ),
                            ],
                          ),
                          if(widget.checkoutResponse!.data!.shippingFees != null)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'مصاريف الشحن',
                                style: kTextGreyBody,
                              ),
                              Text(
                                '${widget.checkoutResponse!.data!.shippingFees} ر.س',
                                style: kTextGreyBody,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'VAT',
                                style: kTextGreyBody,
                              ),
                              Text(
                                '${widget.checkoutResponse!.data!.vat}%',
                                style: kTextGreyBody,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الإجمالي',
                                style: kTextBlackBody,
                              ),
                              Text(
                                '${widget.checkoutResponse!.data!.total} ر.س',
                                style: kTextBlackBody,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //products
                if (widget.checkoutResponse!.data!.products != null)
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('مراجعة المنتجات',
                              style: kTextPrimaryHeader)),
                      ...widget.checkoutResponse!.data!.products!
                          .map((singleProduct) {
                        return Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    blurRadius: 3)
                              ]),
                          child: ListTile(
                            selected: true,
                            title: Text(
                              singleProduct.name!,
                              style: kTextBlackBody,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${YemString.price}',
                                      style: kTextGreyFooter,
                                    ),
                                    Text(
                                      '${singleProduct.price} ريال',
                                      style: kTextGreyFooter,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${YemString.quantity}',
                                      style: kTextGreyFooter,
                                    ),
                                    Text(
                                      '${singleProduct.quantity}',
                                      style: kTextGreyFooter,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),

                //shipping address
                if (widget.checkoutResponse!.data!.address != null)
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child:
                              Text('عنوان الشحن', style: kTextPrimaryHeader)),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 0.2),
                        ),
                        child: ListTile(
                          title: Text(
                            widget.checkoutResponse!.data!.address!.address!,
                            style: kTextBlackBody,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${YemString.homeNumber}: ${widget.checkoutResponse!.data!.address!.houseNumber}',
                                style: kTextGreyBody,
                              ),
                              Text(
                                '${YemString.city}: ${widget.checkoutResponse!.data!.address!.city}',
                                style: kTextGreyBody,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                //payment methods
                if (widget.checkoutResponse!.data!.payOption != null)
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child:
                              Text('طريقة الدفع', style: kTextPrimaryHeader)),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 0.2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                selected: true,
                                title: Text(
                                  widget.checkoutResponse!.data!.payOption!.name!,
                                  style: kTextBlackBody,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${YemString.branch_country}: ${widget.checkoutResponse!.data!.payOption!.branchCountry}',
                                      style: kTextGreyFooter,
                                    ),
                                    Text(
                                      '${YemString.branch_number}: ${widget.checkoutResponse!.data!.payOption!.branchNumber}',
                                      style: kTextGreyFooter,
                                    ),
                                    Text(
                                      '${YemString.iban_number}: ${widget.checkoutResponse!.data!.payOption!.ibanNumber}',
                                      style: kTextGreyFooter,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: widget.checkoutResponse!.data!
                                              .payOption!.logo !=
                                          null
                                      ? BASE_URL_IMAGE_PATH +
                                          widget.checkoutResponse!.data!.payOption!
                                              .logo!
                                      : '',
                                  fit: BoxFit.cover,
                                  width: 45,
                                  height: 45,
                                  placeholder: (ctx, url) {
                                    return Image.asset(
                                      'assets/img/logo_white_bk.png',
                                      fit: BoxFit.cover,
                                      height: 30,
                                      width: 30,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    if (!createOrderLoading) createOrder(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimarySwatchColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 0.8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: createOrderLoading
                          ? Center(
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 0.8,
                                    backgroundColor: Colors.white,
                                  )),
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'إتمام عملية الشراء',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createOrder(BuildContext context) async {
    createOrderLoading = true;
    setState(() {});
    try {
      String response = await createOrderRequest(context, createOrder: true);
      createOrderLoading = false;
      setState(() {});
      Navigator.of(context).pushNamed(SuccessCreateOrderView.id);
    } catch (e) {
      if (e == 'network') {
        Toast.show(YemString.noInternetConnection,
            duration: Toast.lengthShort, gravity: Toast.bottom);
      } else if (e == 'server') {
        Toast.show(YemString.server_error,
            duration: Toast.lengthShort, gravity: Toast.bottom);
      } else {
        Toast.show('${e}',
            duration: Toast.lengthShort, gravity: Toast.bottom);
      }
    }
    createOrderLoading = false;
    setState(() {});
  }
}
