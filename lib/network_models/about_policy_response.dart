// To parse this JSON data, do
//
//     final jsonAboutAndPolicyResponse = jsonAboutAndPolicyResponseFromJson(jsonString);

import 'dart:convert';

JsonAboutAndPolicyResponse jsonAboutAndPolicyResponseFromJson(String str) => JsonAboutAndPolicyResponse.fromJson(json.decode(str));

String jsonAboutAndPolicyResponseToJson(JsonAboutAndPolicyResponse data) => json.encode(data.toJson());

class JsonAboutAndPolicyResponse {
  bool? status;
  String? message;
  List<Datum>? data;

  JsonAboutAndPolicyResponse({
    this.status,
    this.message,
    this.data,
  });

  factory JsonAboutAndPolicyResponse.fromJson(Map<String, dynamic> json) => JsonAboutAndPolicyResponse(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  dynamic photo;
  String? type;
  dynamic createdAt;
  dynamic updatedAt;
  String? title;
  String? content;
  String? description;
  String? keywords;

  Datum({
    this.id,
    this.photo,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.content,
    this.description,
    this.keywords,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    photo: json["photo"],
    type: json["type"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    title: json["title"],
    content: json["content"],
    description: json["description"],
    keywords: json["keywords"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "photo": photo,
    "type": type,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "title": title,
    "content": content,
    "description": description,
    "keywords": keywords,
  };
}
