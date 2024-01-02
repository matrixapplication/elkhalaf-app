// To parse this JSON data, do
//
//     final citiesResponse = citiesResponseFromMap(jsonString);

import 'dart:convert';

CitiesResponse citiesResponseFromMap(String str) => CitiesResponse.fromMap(json.decode(str));

String citiesResponseToMap(CitiesResponse data) => json.encode(data.toMap());

class CitiesResponse {
  CitiesResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<SingleCity>? data;

  factory CitiesResponse.fromMap(Map<String, dynamic> json) => CitiesResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SingleCity>.from(json["data"].map((x) => SingleCity.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class SingleCity {
  SingleCity({
    this.id,
    this.countryId,
    this.status,
    this.shipping,
    this.createdAt,
    this.updatedAt,
    this.city,
  });

  int? id;
  int? countryId;
  int? status;
  int? shipping;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? city;

  factory SingleCity.fromMap(Map<String, dynamic> json) => SingleCity(
    id: json["id"] == null ? null : json["id"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    status: json["status"] == null ? null : json["status"],
    shipping: json["shipping"] == null ? null : json["shipping"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    city: json["city"] == null ? null : json["city"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "country_id": countryId == null ? null : countryId,
    "status": status == null ? null : status,
    "shipping": shipping == null ? null : shipping,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "city": city == null ? null : city,
  };
}
