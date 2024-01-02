// To parse this JSON data, do
//
//     final jsonCountriesResponse = jsonCountriesResponseFromJson(jsonString);

import 'dart:convert';

JsonCountriesResponse jsonCountriesResponseFromJson(String str) => JsonCountriesResponse.fromJson(json.decode(str));

String jsonCountriesResponseToJson(JsonCountriesResponse data) => json.encode(data.toJson());

class JsonCountriesResponse {
  bool? status;
  String? message;
  List<Datum>? data;

  JsonCountriesResponse({
    this.status,
    this.message,
    this.data,
  });

  factory JsonCountriesResponse.fromJson(Map<String, dynamic> json) => JsonCountriesResponse(
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
  String? code;
  String? country;
  List<City>? cities;

  Datum({
    this.id,
    this.code,
    this.country,
    this.cities,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    country: json["country"],
    cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "country": country,
    "cities": List<dynamic>.from(cities!.map((x) => x.toJson())),
  };
}

class City {
  int? id;
  int? countryId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? city;

  City({
    this.id,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.city,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    countryId: json["country_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "city": city,
  };
}
