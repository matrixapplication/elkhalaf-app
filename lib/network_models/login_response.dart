// To parse this JSON data, do
//
//     final jsonLoginResponse = jsonLoginResponseFromJson(jsonString);

import 'dart:convert';

JsonLoginResponse jsonLoginResponseFromJson(String str) => JsonLoginResponse.fromJson(json.decode(str));

String jsonLoginResponseToJson(JsonLoginResponse data) => json.encode(data.toJson());

class JsonLoginResponse {
  bool? status;
  String? message;
  Data? data;

  JsonLoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory JsonLoginResponse.fromJson(Map<String, dynamic> json) => JsonLoginResponse(
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
  String? name;
  dynamic email;
  String? phone;
  dynamic emailVerifiedAt;
  dynamic country;
  dynamic city;
  dynamic address;
  dynamic avatar;
  int? type;
  int? status;
  late DateTime createdAt;
  late DateTime updatedAt;
  String? token;

  Data({
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
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    country: json["country"],
    city: json["city"],
    address: json["address"],
    avatar: json["avatar"],
    type: json["type"] == null ? 1 : json["type"] ,
    status: json["status"]== null ? 1 : json["status"] , // 1 -> user , 0 -> admin
    token: json["token"],
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "token": token,
  };
}
