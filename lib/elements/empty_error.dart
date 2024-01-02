import 'package:alkhalafsheep/const/_const.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class EmptyErrorWidget extends StatelessWidget {
  final Function? refresh;

  EmptyErrorWidget({this.refresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info,size: 90,),
          SizedBox(height: 12),
          Text(YemString.empty),
          SizedBox(height: 8),

        ],
      ),
    );
  }
}
