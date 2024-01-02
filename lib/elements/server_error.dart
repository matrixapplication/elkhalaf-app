import 'package:alkhalafsheep/const/_const.dart';
import 'package:flutter/material.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';

class ServerErrorWidget extends StatelessWidget {
  final Function? refresh;

  ServerErrorWidget({this.refresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(YemString.serverError),
          SizedBox(height: 8),
          FlatButton(
            onPressed: refresh as void Function()?,
            child: Text(
              YemString.retry,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            color: PRIMARY_COLOR,
          )
        ],
      ),
    );
  }
}
