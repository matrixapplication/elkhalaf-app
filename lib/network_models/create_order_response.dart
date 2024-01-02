// To parse this JSON data, do
//
//     final jsonCreateOrderResponse = jsonCreateOrderResponseFromJson(jsonString);

import 'dart:convert';

JsonCreateOrderResponse jsonCreateOrderResponseFromJson(String str) => JsonCreateOrderResponse.fromJson(json.decode(str));

String jsonCreateOrderResponseToJson(JsonCreateOrderResponse data) => json.encode(data.toJson());

class JsonCreateOrderResponse {
  bool? status;
  String? message;
  Data? data;

  JsonCreateOrderResponse({
    this.status,
    this.message,
    this.data,
  });

  factory JsonCreateOrderResponse.fromJson(Map<String, dynamic> json) => JsonCreateOrderResponse(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  int? id;
  int? orderCode;
  List<Item>? items;
  int? vat;
  int? shipping;
  int? totla;
  int? status;
  PayOption? payOption;
  int? payStatus;
  User? user;
  String? address;

  Data({
    this.id,
    this.orderCode,
    this.items,
    this.vat,
    this.shipping,
    this.totla,
    this.status,
    this.payOption,
    this.payStatus,
    this.user,
    this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    orderCode: json["order_code"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    vat: json["vat"],
    shipping: json["shipping"],
    totla: json["totla"],
    status: json["status"],
    payOption: PayOption.fromJson(json["pay_option"]),
    payStatus: json["pay_status"],
    user: User.fromJson(json["user"]),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_code": orderCode,
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "vat": vat,
    "shipping": shipping,
    "totla": totla,
    "status": status,
    "pay_option": payOption!.toJson(),
    "pay_status": payStatus,
    "user": user!.toJson(),
    "address": address,
  };
}

class Item {
  int? quantity;
  int? price;
  String? name;
  List<dynamic>? options;
  dynamic photo;

  Item({
    this.quantity,
    this.price,
    this.name,
    this.options,
    this.photo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    quantity: json["quantity"],
    price: json["price"],
    name: json["name"],
    options: List<dynamic>.from(json["options"].map((x) => x)),
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "price": price,
    "name": name,
    "options": List<dynamic>.from(options!.map((x) => x)),
    "photo": photo,
  };
}

class PayOption {
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

  factory PayOption.fromJson(Map<String, dynamic> json) => PayOption(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    serviceName: json["service_name"],
    ibanNumber: json["iban_number"],
    number: json["number"],
    branchNumber: json["branch_number"],
    branchCountry: json["branch_country"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "service_name": serviceName,
    "iban_number": ibanNumber,
    "number": number,
    "branch_number": branchNumber,
    "branch_country": branchCountry,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class User {
  int? id;
  String? name;
  dynamic email;
  String? phone;
  dynamic emailVerifiedAt;
  int? country;
  dynamic city;
  dynamic address;
  dynamic avatar;
  int? type;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.country,
    this.city,
    this.address,
    this.avatar,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    country: json["country"],
    city: json["city"],
    address: json["address"],
    avatar: json["avatar"],
    type: json["type"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "country": country,
    "city": city,
    "address": address,
    "avatar": avatar,
    "type": type,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
