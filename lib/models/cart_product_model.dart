import 'package:flutter/foundation.dart';


class CartProductModel {
   int id;
   String model_number;
   String weight;
   int price;
   int discount;
   int quantity;
   String name;
   String content;
   String photo;
   String productOptions;
   String? productOptionsString;

  CartProductModel({
    required this.id,
    required this.model_number,
    required this.weight,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.name,
    required this.content,
    required this.photo,
    required this.productOptions,
  });

  Map<String, dynamic> toJson() =>
      <String, dynamic> {
        'id': this.id,
        'model_number': this.model_number,
        'weight': this.weight,
        'price': this.price,
        'discount': this.discount,
        'quantity': this.quantity,
        'name': this.name,
        'content': this.content,
        'photo': this.photo,
        'productOptions': this.productOptions,
      };
}

