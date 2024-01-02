// To parse this JSON data, do
//
//     final checkoutResponse = checkoutResponseFromMap(jsonString);

import 'dart:convert';

CheckoutResponse checkoutResponseFromMap(String str) => CheckoutResponse.fromMap(json.decode(str));

String checkoutResponseToMap(CheckoutResponse data) => json.encode(data.toMap());

class CheckoutResponse {
  CheckoutResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory CheckoutResponse.fromMap(Map<String, dynamic> json) => CheckoutResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toMap(),
  };
}

class Data {
  Data({
    this.payOption,
    this.note,
    this.products,
    this.address,
    this.total,
    this.vat,
    this.shippingFees,
  });

  PayOption? payOption;
  String? note;
  List<Products>? products;
  Address? address;
  int? total;
  int? vat;
  int? shippingFees;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    payOption: json["pay_option"] == null ? null : PayOption.fromMap(json["pay_option"]),
    note: json["note"] == null ? null : json["note"],
    products: json["products"] == null ? null : List<Products>.from(json["products"].map((x) => Products.fromMap(x))),
    address: json["address"] == null ? null : Address.fromMap(json["address"]),
    total: json["total"] == null ? null : json["total"],
    vat: json["vat"] == null ? null : json["vat"],
    shippingFees: json["shipping_fees"] == null ? null : json["shipping_fees"],
  );

  Map<String, dynamic> toMap() => {
    "pay_option": payOption == null ? null : payOption!.toMap(),
    "note": note == null ? null : note,
    "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toMap())),
    "address": address == null ? null : address!.toMap(),
    "total": total == null ? null : total,
    "vat": vat == null ? null : vat,
    "shipping_fees": shippingFees == null ? null : shippingFees,
  };
}

class Address {
  Address({
    this.id,
    this.user,
    this.address,
    this.houseNumber,
    this.isMain,
    this.city,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? user;
  String? address;
  String? houseNumber;
  int? isMain;
  String? city;
  dynamic createdAt;
  dynamic updatedAt;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    id: json["id"] == null ? null : json["id"],
    user: json["user"] == null ? null : json["user"],
    address: json["address"] == null ? null : json["address"],
    houseNumber: json["house_number"] == null ? null : json["house_number"],
    isMain: json["isMain"] == null ? null : json["isMain"],
    city: json["city"] == null ? null : json["city"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "user": user == null ? null : user,
    "address": address == null ? null : address,
    "house_number": houseNumber == null ? null : houseNumber,
    "isMain": isMain == null ? null : isMain,
    "city": city == null ? null : city,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class PayOption {
  PayOption({
    this.id,
    this.name,
    this.logo,
    this.serviceName,
    this.ibanNumber,
    this.number,
    this.branchNumber,
    this.branchCountry,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? logo;
  String? serviceName;
  String? ibanNumber;
  String? number;
  String? branchNumber;
  String? branchCountry;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PayOption.fromMap(Map<String, dynamic> json) => PayOption(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    logo: json["logo"] == null ? null : json["logo"],
    serviceName: json["service_name"] == null ? null : json["service_name"],
    ibanNumber: json["iban_number"] == null ? null : json["iban_number"],
    number: json["number"] == null ? null : json["number"],
    branchNumber: json["branch_number"] == null ? null : json["branch_number"],
    branchCountry: json["branch_country"] == null ? null : json["branch_country"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "logo": logo == null ? null : logo,
    "service_name": serviceName == null ? null : serviceName,
    "iban_number": ibanNumber == null ? null : ibanNumber,
    "number": number == null ? null : number,
    "branch_number": branchNumber == null ? null : branchNumber,
    "branch_country": branchCountry == null ? null : branchCountry,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}

class Products {
  Products({
    this.name,
    this.quantity,
    this.price,
    this.options,
  });

  String? name;
  int? quantity;
  int? price;
  List<Option>? options;

  factory Products.fromMap(Map<String, dynamic> json) => Products(
    name: json["name"] == null ? null : json["name"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    price: json["price"] == null ? null : json["price"],
    options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "quantity": quantity == null ? null : quantity,
    "price": price == null ? null : price,
    "options": options == null ? null : List<dynamic>.from(options!.map((x) => x.toMap())),
  };
}

class Option {
  Option({
    this.optionId,
    this.optionValue,
  });

  String? optionId;
  String? optionValue;

  factory Option.fromMap(Map<String, dynamic> json) => Option(
    optionId: json["option_id"] == null ? null : json["option_id"],
    optionValue: json["option_value"] == null ? null : json["option_value"],
  );

  Map<String, dynamic> toMap() => {
    "option_id": optionId == null ? null : optionId,
    "option_value": optionValue == null ? null : optionValue,
  };
}
