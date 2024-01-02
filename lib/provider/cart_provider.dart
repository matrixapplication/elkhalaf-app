import 'package:flutter/foundation.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';

class CartProvider with ChangeNotifier {
  List<CartProduct>? _cart = [];
  String? _shippingId ;
  String? _paymentId ;
  String? _note ;


  String? get paymentId => _paymentId;

  set paymentId(String? value) {
    _paymentId = value;
    notifyListeners();
  }

  String? get shippingId => _shippingId;

  set shippingId(String? value) {
    _shippingId = value;
    notifyListeners();
  }

  List<CartProduct>? get cart => _cart;

  set cart(List<CartProduct>? value) {
    _cart = value;
    notifyListeners();
  }

  String? get note => _note;

  set note(String? value) {
    _note = value;
    notifyListeners();
  }
}


class CartProduct {
  CartProduct({
    this.id,
    this.categoryId,
    this.options,
    this.title,
    this.description,
    this.images,
    this.note,
    this.qty = 1,
  });

  int? id;
  int? categoryId;
  int qty;
  List<Option?>? options;
  String? title;
  String? note;
  String? description;
  List<String>? images;
}
