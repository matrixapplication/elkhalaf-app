import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:alkhalafsheep/network_models/checkout_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:provider/provider.dart';

import 'apis.dart';
import 'network_setup.dart';

Future<CheckoutResponse> checkoutRequest(BuildContext context) async {
  CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

  List<CheckoutProducts> products =  [];
  cartProvider.cart!.forEach((element) {
    List<Option> list =  [];
    element.options!.forEach((element) {
      list.add(new Option(
          optionId: element!.id,
          optionValue: '${element.singleOptions!.first.id}'));
    });
    products.add(CheckoutProducts(
        note: element.note,
        options: list,
        productId: element.id,
        quantity: element.qty));
  });

  CheckoutRequestData checkoutRequestData = CheckoutRequestData(
    addressId: cartProvider.shippingId,
    note: cartProvider.note,
    payOption: cartProvider.paymentId,
    products: products,
  );

  Dio dio = await networkHeaderSetup(false, timeout: 15);
  try {
    Response response = await dio
        .post(kCheckout, data: checkoutRequestData)
        .whenComplete(() {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      JsonBasicResponse basicJsonResponse =
          JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        CheckoutResponse apiResponse = CheckoutResponse.fromMap(response.data);
        return apiResponse;
      } else {
        return Future.error('auth');
      }
    } else {
      return Future.error('server');
    }
  } on DioError catch (error) {
    return Future.error(networkHandleError(error));
  }
}

class CheckoutRequestData {
  CheckoutRequestData({
    this.payOption,
    this.note,
    this.addressId,
    this.products,
  });

  String? payOption;
  String? note;
  String? addressId;
  List<CheckoutProducts>? products;

  Map<String, dynamic> toJson() => {
        "pay_option": payOption == null ? null : payOption,
        "note": note == null ? '' : note,
        "address_id": addressId == null ? null : addressId,
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class CheckoutProducts {
  CheckoutProducts({
    this.productId,
    this.quantity,
    this.note,
    this.options,
  });

  int? productId;
  int? quantity;
  String? note;
  List<Option>? options;

  Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "quantity": quantity == null ? null : quantity,
        "note": note == null ? '' : note,
        "options": options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.optionId,
    this.optionValue,
  });

  String? optionId;
  String? optionValue;

  Map<String, dynamic> toJson() => {
        "option_id": optionId == null ? null : optionId,
        "option_value": optionValue == null ? null : optionValue,
      };
}
