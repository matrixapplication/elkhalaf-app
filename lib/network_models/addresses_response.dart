// To parse this JSON data, do
//
//     final addressesResponse = addressesResponseFromJson(jsonString);

import 'dart:convert';

AddressesResponse addressesResponseFromJson(String str) => AddressesResponse.fromJson(json.decode(str));

String addressesResponseToJson(AddressesResponse data) => json.encode(data.toJson());

class AddressesResponse {
  AddressesResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<SingleAddress>? data;

  factory AddressesResponse.fromJson(Map<String, dynamic> json) => AddressesResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SingleAddress>.from(json["data"].map((x) => SingleAddress.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleAddress {
  SingleAddress({
    this.id,
    this.user,
    this.address,
    this.houseNumber,
    this.isMain,
    this.city,
    this.cityName,
  });

  int? id;
  int? user;
  String? address;
  String? houseNumber;
  int? isMain;
  int? city;
  String? cityName;

  factory SingleAddress.fromJson(Map<String, dynamic> json) => SingleAddress(
    id: json["id"] == null ? null : json["id"],
    user: json["user"] == null ? null : json["user"],
    address: json["address"] == null ? null : json["address"],
    houseNumber: json["house_number"] == null ? null : json["house_number"],
    isMain: json["isMain"] == null ? null : json["isMain"],
    city: json["city"] == null ? null : json["city"],
    cityName: json["city_name"] == null ? null : json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user": user == null ? null : user,
    "address": address == null ? null : address,
    "house_number": houseNumber == null ? null : houseNumber,
    "isMain": isMain == null ? null : isMain,
    "city": city == null ? null : city,
    "city_name": cityName == null ? null : cityName,
  };
}
