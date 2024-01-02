import 'package:flutter/material.dart';

class NotificationController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.notifications_off,size: 150,color: Colors.orangeAccent,),
        SizedBox(height: 16,),
        Text('لا يوجد تنبيهات',style: TextStyle(fontSize: 18),)
      ],
    );
  }
}
