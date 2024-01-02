// To parse this JSON data, do
//
//     final jsonBasicResponse = jsonBasicResponseFromJson(jsonString);

import 'dart:convert';

JsonBasicResponse jsonBasicResponseFromJson(String str) => JsonBasicResponse.fromJson(json.decode(str));

String jsonBasicResponseToJson(JsonBasicResponse data) => json.encode(data.toJson());

class JsonBasicResponse {
  bool? status;
  String? message;

  JsonBasicResponse({
    this.status,
    this.message,
  });

  factory JsonBasicResponse.fromJson(Map<String, dynamic> json) => JsonBasicResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
