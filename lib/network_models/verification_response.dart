// To parse this JSON data, do
//
//     final jsonVerificatioResponse = jsonVerificatioResponseFromJson(jsonString);

import 'dart:convert';

JsonVerificatioResponse jsonVerificatioResponseFromJson(String str) => JsonVerificatioResponse.fromJson(json.decode(str));

String jsonVerificatioResponseToJson(JsonVerificatioResponse data) => json.encode(data.toJson());

class JsonVerificatioResponse {
  bool? status;
  String? message;
  Data? data;

  JsonVerificatioResponse({
    this.status,
    this.message,
    this.data,
  });

  factory JsonVerificatioResponse.fromJson(Map<String, dynamic> json) => JsonVerificatioResponse(
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
  String? smsCode;
  DateTime? createdAt;
  DateTime? updatedAt;
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
    this.smsCode,
    this.createdAt,
    this.updatedAt,
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
    type: json["type"],
    status: json["status"],
    smsCode: json["sms_code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "sms_code": smsCode,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "token": token,
  };
}
