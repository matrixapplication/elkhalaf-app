// To parse this JSON data, do
//
//     final optionsResponse = optionsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

MainResponse optionsResponseFromMap(String str) => MainResponse.fromMap(json.decode(str));

String optionsResponseToMap(MainResponse data) => json.encode(data.toMap());

class MainResponse {
  MainResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  MainData? data;

  factory MainResponse.fromMap(Map<String, dynamic> json) => MainResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : MainData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toMap(),
  };
}

class MainData   {
  MainData({
    this.video,
    this.sliders,
    this.categories,
    this.products,
    this.whatsapp,
    this.instagram,
    this.tiktok,
    this.snapchat,
    this.twitter,
    this.about,
    this.policy,
    this.contact,
  });

  String? video;
  List<Slider>? sliders;
  List<Category>? categories;
  List<Product>? products;
  String? whatsapp;
  String? instagram;
  String? tiktok;
  String? snapchat;
  String? twitter;
  String? about;
  String? policy;
  String? contact;



  factory MainData.fromMap(Map<String, dynamic> json) => MainData(
    video: json["video"] == null ? null : json["video"],
    sliders: json["sliders"] == null ? null : List<Slider>.from(json["sliders"].map((x) => Slider.fromMap(x))),
    categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    whatsapp: json["whatsapp"] == null ? null : json["whatsapp"],
    instagram: json["instagram"] == null ? null : json["instagram"],
    snapchat: json["snapchat"] == null ? null : json["snapchat"],
    tiktok: json["tiktok"] == null ? null : json["tiktok"],
    twitter: json["twitter"] == null ? null : json["twitter"],
    about: json["about"] == null ? null : json["about"],
    policy: json["policy"] == null ? null : json["policy"],
    contact: json["contact"] == null ? null : json["contact"],
  );

  Map<String, dynamic> toMap() => {
    "video": video == null ? null : video,
    "sliders": sliders == null ? null : List<dynamic>.from(sliders!.map((x) => x.toMap())),
    "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x.toMap())),
    "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toMap())),
    "whatsapp": whatsapp == null ? null : whatsapp,
    "instagram": instagram == null ? null : instagram,
    "snapchat": snapchat == null ? null : snapchat,
    "twitter": twitter == null ? null : twitter,
    "about": about == null ? null : about,
    "policy": policy == null ? null : policy,
    "contact": contact == null ? null : contact,
  };
}

class Category {
  Category({
    this.id,
    this.title,
    this.image,
  });

  int? id;
  String? title;
  String? image;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
  };
}

class Product {
  Product({
    this.id,
    this.categoryId,
    this.title,
    this.description,
    this.images,
    this.showInOffers,
    this.showInSpecialOffer,
    this.productAvailable,
    this.options,
  });

  int? id;
  int? categoryId;
  String? title;
  String? description;
  List<String>? images;
  bool? showInOffers;
  bool? showInSpecialOffer;
  bool? productAvailable;
  List<Option>? options;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"] == null ? null : json["id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    showInOffers: json["showInOffers"] == null ? null : json["showInOffers"],
    showInSpecialOffer: json["showInSpecialOffer"] == null ? null : json["showInSpecialOffer"],
    productAvailable: json["productAvailable"] == null ? null : json["productAvailable"],
    options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "category_id": categoryId == null ? null : categoryId,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
    "showInOffers": showInOffers == null ? null : showInOffers,
    "showInSpecialOffer": showInSpecialOffer == null ? null : showInSpecialOffer,
    "productAvailable": productAvailable == null ? null : productAvailable,
    "options": options == null ? null : List<dynamic>.from(options!.map((x) => x.toMap())),
  };
}

class Option {
  Option({
    this.id,
    this.title,
    this.singleOptions,
    this.isItRequired,
  });

  String? id;
  String? title;
  List<SingleOption>? singleOptions;
  bool? isItRequired;

  factory Option.fromMap(Map<String, dynamic> json) => Option(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    singleOptions: json["single_options"] == null ? null : List<SingleOption>.from(json["single_options"].map((x) => SingleOption.fromMap(x))),
    isItRequired: json["isItRequired"] == null ? null : json["isItRequired"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "single_options": singleOptions == null ? null : List<dynamic>.from(singleOptions!.map((x) => x.toMap())),
    "isItRequired": isItRequired == null ? null : isItRequired,
  };
}

class SingleOption {
  SingleOption({
    this.id,
    this.title,
    this.price,
    this.status,
  });

  int? id;
  String? title;
  int? price;
  int? status;

  factory SingleOption.fromMap(Map<String, dynamic> json) => SingleOption(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    price: json["price"] == null ? 0 : json["price"],
    status: json["status"] == null ? 1 : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "price": price == null ? null : price,
    "status": status == null ? null : status,
  };
}

class Slider {
  Slider({
    this.id,
    this.image,
    this.text,
  });

  int? id;
  String? image;
  String? text;

  factory Slider.fromMap(Map<String, dynamic> json) => Slider(
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "image": image == null ? null : image,
    "text": text == null ? null : text,
  };
}
