import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum AlertsType { error, success, info }

class Alerts {
  static void showActionSnackBar(
    BuildContext context, {
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    Duration duration = Durations.long1,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: Color(0xff34313B),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: SnackBarAction(
            label: actionLabel,
            onPressed: onActionPressed,
            textColor: Colors.white),
        content: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static void showToast(
    String message, [
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.CENTER,
  ]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      fontSize: 14,
    );
  }

  static Color _getColor(AlertsType alertsType) {
    switch (alertsType) {
      case AlertsType.error:
        return Colors.red;
      case AlertsType.success:
        return Colors.green;
      case AlertsType.info:
        return Color(0xff34313B);
    }
  }
}
