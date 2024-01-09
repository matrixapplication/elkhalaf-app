
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';

class YemSnackBar {
  void showServerErrorConnection(
      {Function? function,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      int durationInSeconds = 4}) {
    SnackBar snackBar;
    if (function != null)
      snackBar = SnackBar(
        content: Text(YemString.errorServerConnection),
        duration: Duration(seconds: durationInSeconds),
        action: SnackBarAction(
          onPressed: function as void Function(),
          label: YemString.refreshPage,
        ),
      );
    else
      snackBar = SnackBar(
        content: Text(YemString.errorServerConnection),
        duration: Duration(seconds: durationInSeconds),
      );

    scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  void showNoInternetConnection(
      {Function? function,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      int durationInSeconds = 4}) {
    SnackBar snackBar;
    if (function != null)
      snackBar = SnackBar(
        content: Text(YemString.noInternetConnection),
        duration: Duration(seconds: durationInSeconds),
        action: SnackBarAction(
          onPressed: function as void Function(),
          label: YemString.refreshPage,
        ),
      );
    else
      snackBar = SnackBar(
        content: Text(YemString.noInternetConnection),
        duration: Duration(seconds: durationInSeconds),
      );
    scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  void showSnackBarMessage(
      {required String text,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      int durationInSeconds = 4}) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: durationInSeconds),
    );
    scaffoldKey.currentState?.showSnackBar(snackBar);
  }
}
