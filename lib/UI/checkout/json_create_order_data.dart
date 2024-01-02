// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
//
// JsonCreateOrderData jsonCreateOrderDataFromJson(String str) =>
//     JsonCreateOrderData.fromJson(json.decode(str));
//
// String jsonCreateOrderDataToJson(JsonCreateOrderData data) =>
//     json.encode(data.toJson());
//
// class JsonCreateOrderData {
//   List<Item> items;
//   int payOption;
//   double latitude;
//   double longitude;
//   int addressId;
//   String note;
//
//   JsonCreateOrderData({
//     this.items,
//     this.payOption,
//     this.addressId,
//     this.latitude,
//     this.longitude,
//     this.note,
//   });
//
//   factory JsonCreateOrderData.fromJson(Map<String, dynamic> json) =>
//       JsonCreateOrderData(
//         items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//         payOption: json["pay_option"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         addressId: json["address_id"],
//         note: json["note"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "items": List<dynamic>.from(items.map((x) => x.toJson())),
//         "pay_option": payOption,
//         "latitude": latitude,
//         "longitude": longitude,
//         "address_id": addressId,
//         "note": note,
//       };
// }
//
// class Item {
//   int productId;
//   int quantity;
//   String weight;
//   String chopping;
//   String note;
//   List<int> options;
//
//   Item({
//     @required this.productId,
//     @required this.quantity,
//     @required this.options,
//     @required this.weight,
//     @required this.chopping,
//     @required this.note,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//         productId: json["product_id"],
//         quantity: json["quantity"],
//         weight: json["weight"],
//         chopping: json["chopping"],
//         note: json["note"],
//         options: List<int>.from(json["options"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "product_id": productId,
//         "quantity": quantity,
//         "weight": weight,
//         "chopping": chopping,
//         "note": quantity,
//         "options": List<dynamic>.from(options.map((x) => x)),
//       };
// }
