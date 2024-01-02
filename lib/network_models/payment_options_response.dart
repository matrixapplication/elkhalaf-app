// To parse this JSON data, do
//
//     final jsonPaymentOptionsResponse = jsonPaymentOptionsResponseFromJson(jsonString);

import 'dart:convert';

JsonPaymentOptionsResponse jsonPaymentOptionsResponseFromJson(String str) => JsonPaymentOptionsResponse.fromJson(json.decode(str));

String jsonPaymentOptionsResponseToJson(JsonPaymentOptionsResponse data) => json.encode(data.toJson());

class JsonPaymentOptionsResponse {
  bool? status;
  String? message;
  PaymentMethods? data;

  JsonPaymentOptionsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory JsonPaymentOptionsResponse.fromJson(Map<String, dynamic> json) => JsonPaymentOptionsResponse(
    status: json["status"],
    message: json["message"],
    data: PaymentMethods.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class PaymentMethods {
  List<SinglePayment>? data;
  int? tax;
  int? shipping;

  PaymentMethods({
    this.data,
    this.tax,
    this.shipping,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
    data: List<SinglePayment>.from(json["data"].map((x) => SinglePayment.fromJson(x))),
    tax: json["tax"],
    shipping: json["shipping"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "tax": tax,
    "shipping": shipping,
  };
}

class SinglePayment {
  int? id;
  String? name;
  String? logo;
  String? serviceName;
  String? ibanNumber;
  String? number;
  String? branchNumber;
  String? branchCountry;
  DateTime? createdAt;
  DateTime? updatedAt;

  SinglePayment({
    this.id,
    this.name,
    this.logo,
    this.serviceName,
    this.ibanNumber,
    this.number,
    this.branchNumber,
    this.branchCountry,
    this.createdAt,
    this.updatedAt,
  });

  factory SinglePayment.fromJson(Map<String, dynamic> json) => SinglePayment(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    serviceName: json["service_name"],
    ibanNumber: json["iban_number"],
    number: json["number"],
    branchNumber: json["branch_number"],
    branchCountry: json["branch_country"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "service_name": serviceName,
    "iban_number": ibanNumber,
    "number": number,
    "branch_number": branchNumber,
    "branch_country": branchCountry,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
