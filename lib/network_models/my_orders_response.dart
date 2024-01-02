// To parse this JSON data, do
//
//     final jsonMyOrdersResponse = jsonMyOrdersResponseFromJson(jsonString);

import 'dart:convert';

JsonMyOrdersResponse jsonMyOrdersResponseFromJson(String str) => JsonMyOrdersResponse.fromJson(json.decode(str));


class JsonMyOrdersResponse {
  JsonMyOrdersResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory JsonMyOrdersResponse.fromJson(Map<String, dynamic> json) => JsonMyOrdersResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.data,
    this.links,
    this.meta,
  });

  List<SingleOrder>? data;
  Links? links;
  Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? null : List<SingleOrder>.from(json["data"].map((x) => SingleOrder.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );


}

class SingleOrder {
  SingleOrder({
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
    this.houseNumber,
    this.address,
    this.note,
    this.longitude,
    this.latitude,
    this.rating,
    this.ratingNote,
  });

  int? id;
  String? orderCode;
  List<Item>? items;
  double? vat;
  double? shipping;
  double? totla;
  String? status;
  dynamic payOption;
  int? payStatus;
  User? user;
  String? houseNumber;
  String? address;
  String? note;
  String? longitude;
  String? latitude;
  dynamic rating;
  dynamic ratingNote;

  factory SingleOrder.fromJson(Map<String, dynamic> json) => SingleOrder(
    id: json["id"] == null ? null : json["id"],
    orderCode: json["order_code"] == null ? null : json["order_code"],
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    vat: json["vat"] == null ? null : json["vat"].toDouble(),
    shipping: json["shipping"] == null ? null : json["shipping"].toDouble(),
    totla: json["totla"] == null ? null : json["totla"].toDouble(),
    status: json["status"] == null ? null : json["status"],
    payOption: json["pay_option"] is String?json["pay_option"]:PayOptionClass.fromJson(json["pay_option"]),
    payStatus: json["pay_status"] == null ? null : json["pay_status"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    houseNumber: json["house_number"] == null ? null : json["house_number"],
    address: json["address"] == null ? null :json["address"],
    note: json["note"] == null ? '' : json["note"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    ratingNote: json["rating_note"],
  );

}




class Item {
  Item({
    this.quantity,
    this.price,
    this.name,
    this.weight,
    this.chopping,
    this.minced,
    this.mincedPrice,
    this.rice,
    this.cooking,
    this.note,
  });

  int? quantity;
  int? price;
  String? name;
  String? weight;
  String? chopping;
  dynamic minced;
  int? mincedPrice;
  dynamic rice;
  dynamic cooking;
  dynamic note;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    quantity: json["quantity"] == null ? null : json["quantity"],
    price: json["price"] == null ? null : json["price"],
    name: json["name"] == null ? null : json["name"],
    weight: json["weight"] == null ? null : json["weight"],
    chopping: json["chopping"] == null ? null : json["chopping"],
    minced: json["minced"],
    mincedPrice: json["minced_price"] == null ? null : json["minced_price"],
    rice: json["rice"],
    cooking: json["cooking"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity == null ? null : quantity,
    "price": price == null ? null : price,
    "name": name == null ? null : name,
    "weight": weight == null ? null : weight,
    "chopping": chopping == null ? null : chopping,
    "minced": minced,
    "minced_price": mincedPrice == null ? null : mincedPrice,
    "rice": rice,
    "cooking": cooking,
    "note": note,
  };
}

class PayOptionClass {
  PayOptionClass({
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

  factory PayOptionClass.fromJson(Map<String, dynamic> json) => PayOptionClass(
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

  Map<String, dynamic> toJson() => {
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




class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.country,
    this.city,
    this.houseNumber,
    this.address,
    this.avatar,
    this.type,
    this.status,
    this.smsCode,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic email;
  String? phone;
  dynamic emailVerifiedAt;
  dynamic country;
  dynamic city;
  dynamic houseNumber;
  dynamic address;
  dynamic avatar;
  int? type;
  int? status;
  String? smsCode;
  String? fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null :  json["name"],
    email: json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    country: json["country"],
    city: json["city"],
    houseNumber: json["house_number"],
    address: json["address"],
    avatar: json["avatar"],
    type: json["type"] == null ? null : json["type"],
    status: json["status"] == null ? null : json["status"],
    smsCode: json["sms_code"] == null ? null : json["sms_code"],
    fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email,
    "phone": phone == null ? null : phone,
    "email_verified_at": emailVerifiedAt,
    "country": country,
    "city": city,
    "house_number": houseNumber,
    "address": address,
    "avatar": avatar,
    "type": type == null ? null : type,
    "status": status == null ? null : status,
    "sms_code": smsCode == null ? null : smsCode,
    "fcm_token": fcmToken == null ? null : fcmToken,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}


class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"] == null ? null : json["first"],
    last: json["last"] == null ? null : json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first == null ? null : first,
    "last": last == null ? null : last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}


