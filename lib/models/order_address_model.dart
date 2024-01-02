import 'package:flutter/cupertino.dart';

class OrderAddressModel {
  final int? id;
  final String? address;
  final int? user;
  final String? house_number;
  final String? cityName;
  final int? cityId;
  final int? isMain;

  OrderAddressModel(
      {required this.id,
      required this.address,
      required this.user,
      required this.house_number,
      required this.cityId,
      required this.cityName,
      required this.isMain});
}
