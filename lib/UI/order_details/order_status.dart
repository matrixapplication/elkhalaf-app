import 'package:alkhalafsheep/network_models/my_orders_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  final SingleOrder? modelMyOrders;

  const OrderStatus({this.modelMyOrders});

  @override
  Widget build(BuildContext context) {
    int selectedStep = 1;
    switch (modelMyOrders!.status) {
      case 'تم استلام طلبك وجاري تأكيده':
        selectedStep = 1;
        break;
      case 'تم تأكيد طلبك':
        selectedStep = 2;
        break;
      case 'استعد! الذبيحة في طريقها لبيتكم':
        selectedStep = 3;
        break;
      case 'تم تسليم الذبيحة وعليك بألف عافية':
        selectedStep = 4;
        break;
      case 'مرفوض':
        selectedStep = -1;
        break;
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        color: selectedStep == 1
                            ? kPrimaryColor
                            : selectedStep < 1
                                ? Colors.grey
                                : Colors.green),
                    child: Icon(Icons.check_circle,
                        color: Colors.white, size: 50)),
                SizedBox(width: 10),
                Text(
                  'تم استلام طلبك وجاري تأكيده',
                  style: TextStyle(
                      fontWeight: selectedStep == 1
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                  height: 40,
                  width: 2,
                  color: selectedStep >= 2 ? Colors.green : Colors.grey),
            ),
            Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        color: selectedStep == 2
                            ? Colors.yellow.shade500
                            : selectedStep < 2
                                ? Colors.grey
                                : Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.playlist_add_check,
                          color: Colors.white, size: 34),
                    )),
                SizedBox(width: 10),
                Text(
                  'تم تأكيد طلبك',
                  style: TextStyle(
                      fontWeight: selectedStep == 2
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                  height: 40,
                  width: 2,
                  color: selectedStep >= 3 ? Colors.green : Colors.grey),
            ),
            Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        color: selectedStep == 3
                            ? kPrimaryColor
                            : selectedStep < 3
                                ? Colors.grey
                                : Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.directions_car,
                          color: Colors.white, size: 34),
                    )),
                SizedBox(width: 10),
                Text(
                  'استعد! الذبيحة في طريقها لبيتكم',
                  style: TextStyle(
                      fontWeight: selectedStep == 3
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                  height: 40,
                  width: 2,
                  color: selectedStep >= 4 ? Colors.green : Colors.grey),
            ),
            Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        color: selectedStep == 4
                            ? kPrimaryColor
                            : selectedStep < 4
                                ? Colors.grey
                                : Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Icon(Icons.done_all, color: Colors.white, size: 34),
                    )),
                SizedBox(width: 10),
                Text(
                  'تم تسليم الذبيحة وعليك بألف عافية',
                  style: TextStyle(
                      fontWeight: selectedStep == 4
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (selectedStep == -1)
              Row(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                          color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.close, color: Colors.white, size: 34),
                      )),
                  SizedBox(width: 10),
                  Text(
                    'تم رفض الطلب',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
