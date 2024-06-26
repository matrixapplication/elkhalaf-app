import 'package:alkhalafsheep/elements/alerts.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/checkout/checkout_controller.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network/checkout_request.dart';
import 'package:alkhalafsheep/network_models/checkout_response.dart';
import 'package:alkhalafsheep/network_models/payment_options_response.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:provider/provider.dart';

class PaymentMethodView extends StatefulWidget {
  final List<SinglePayment>? list;

  PaymentMethodView({this.list});

  @override
  _PaymentMethodViewState createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  bool checkoutRequestLoading = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              ...widget.list!.map((e) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey, width: 0.2),
                      boxShadow: [
                        BoxShadow(
                            color: cartProvider.paymentId == '${e.id}'
                                ? kPrimaryColor
                                : Colors.grey,
                            offset: Offset(3, 3),
                            blurRadius: 10),
                      ]),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          selected: true,
                          value: '${e.id}',
                          groupValue: cartProvider.paymentId == null
                              ? '0'
                              : cartProvider.paymentId,
                          title: Text(
                            e.name!,
                            style: kTextBlackBody,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${YemString.branch_country}: ${e.branchCountry}',
                                style: kTextGreyFooter,
                              ),
                              Text(
                                '${YemString.branch_number}: ${e.branchNumber}',
                                style: kTextGreyFooter,
                              ),
                              Text(
                                '${YemString.iban_number}: ${e.ibanNumber}',
                                style: kTextGreyFooter,
                              ),
                            ],
                          ),
                          onChanged: (dynamic value) {
                            cartProvider.paymentId = '${value}';
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: e.logo != null
                                ? BASE_URL_IMAGE_PATH + e.logo!
                                : '',
                            errorWidget: (e,r,t){
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/img/holder.png',
                                  fit: BoxFit.cover,
                                  height: 30,
                                  width: 30,
                                ),
                              );
                          },
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
                );
              }).toList(),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (cartProvider.paymentId == null ||
                cartProvider.paymentId == '0') {
              Flushbar(
                titleText: Text(''),
                message: 'يرجي اختيار طريقة الدفع',
                duration: Duration(seconds: 2),
                flushbarPosition: FlushbarPosition.BOTTOM,
                backgroundColor: Colors.red,
              )..show(context);
              return;
            } else {
              if (!checkoutRequestLoading) goToCheckout(context);
            }
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
              child: checkoutRequestLoading
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
                      child: Text(
                        YemString.continuez,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }

  void goToCheckout(BuildContext context) async {
    checkoutRequestLoading = true;
    setState(() {});
    try {
      CheckoutResponse response = await checkoutRequest(context);
      checkoutRequestLoading = false;
      setState(() {});
      Navigator.of(context)
          .pushNamed(CheckoutController.id, arguments: response);
    } catch (e) {
      if (e == 'network') {
        Alerts.showToast(YemString.noInternetConnection);
      } else if (e == 'server') {
        Alerts.showToast(YemString.server_error);
        // Toast.show(YemString.server_error,
        //     duration: Toast.lengthShort, gravity: Toast.bottom);
      } else {
        Alerts.showToast(e.toString());
        // Toast.show('${e}',
        //     duration: Toast.lengthShort, gravity: Toast.bottom);
      }
    }
    checkoutRequestLoading = false;
    setState(() {});
  }
}
