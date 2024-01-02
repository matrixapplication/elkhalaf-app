// To parse this JSON data, do
//
//     final jsonRegisterResponse = jsonRegisterResponseFromJson(jsonString);

import 'dart:convert';

JsonRegisterResponse jsonRegisterResponseFromJson(String str) => JsonRegisterResponse.fromJson(json.decode(str));

String jsonRegisterResponseToJson(JsonRegisterResponse data) => json.encode(data.toJson());

class JsonRegisterResponse {
  JsonRegisterResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory JsonRegisterResponse.fromJson(Map<String, dynamic> json) => JsonRegisterResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.name,
    this.phone,
    this.country,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.slug,
    this.smsCode,
    this.token,
  });

  String? name;
  String? phone;
  String? country;
  int? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? slug;
  String? smsCode;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    country: json["country"] == null ? null : json["country"],
    status: json["status"] == null ? null : json["status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
    slug: json["slug"] == null ? null : json["slug"],
    smsCode: json["sms_code"] == null ? null : json["sms_code"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "country": country == null ? null : country,
    "status": status == null ? null : status,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "id": id == null ? null : id,
    "slug": slug == null ? null : slug,
    "sms_code": smsCode == null ? null : smsCode,
    "token": token == null ? null : token,
  };
}
