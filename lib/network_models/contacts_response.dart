// To parse this JSON data, do
//
//     final jsonContactsResponse = jsonContactsResponseFromJson(jsonString);

import 'dart:convert';

JsonContactsResponse jsonContactsResponseFromJson(String str) =>
    JsonContactsResponse.fromJson(json.decode(str));

String jsonContactsResponseToJson(JsonContactsResponse data) =>
    json.encode(data.toJson());

class JsonContactsResponse {
  String? code;
  String? message;
  List<Datum>? data;

  JsonContactsResponse({
    this.code,
    this.message,
    this.data,
  });

  factory JsonContactsResponse.fromJson(Map<String, dynamic> json) =>
      JsonContactsResponse(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? userId;
  String? userName;
  String? userEmail;
  String? userImage;

  Datum({
    this.userId,
    this.userName,
    this.userEmail,
    this.userImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userImage: json["user_image"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_image": userImage,
      };
}
