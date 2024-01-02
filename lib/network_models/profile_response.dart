// To parse this JSON data, do
//
//     final jsonProfileResponse = jsonProfileResponseFromJson(jsonString);

import 'dart:convert';

JsonProfileResponse jsonProfileResponseFromJson(String str) => JsonProfileResponse.fromJson(json.decode(str));

String jsonProfileResponseToJson(JsonProfileResponse data) => json.encode(data.toJson());

class JsonProfileResponse {
  JsonProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory JsonProfileResponse.fromJson(Map<String, dynamic> json) => JsonProfileResponse(
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
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.country,
    this.city,
    this.address,
    this.avatar,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic email;
  String? phone;
  String? country;
  dynamic city;
  dynamic address;
  dynamic avatar;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    country: json["country"],
    city: json["city"],
    address: json["address"],
    avatar: json["avatar"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "country": country,
    "city": city,
    "address": address,
    "avatar": avatar,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
