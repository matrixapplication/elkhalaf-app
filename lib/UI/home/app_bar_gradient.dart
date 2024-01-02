import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AppbarHome extends StatelessWidget {
  final String CountNotice;

  const AppbarHome({Key? key, required this.CountNotice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Create responsive height and padding
    final MediaQueryData media = MediaQuery.of(context);
    final double width = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    /// Create component in appbar
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: 58.0 + statusBarHeight,
      decoration: BoxDecoration(color: kPrimaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          SizedBox(width: 8),
          ///  Menu Icon
        /*  InkWell(
            onTap: () {
              Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => TestScreen()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(4),
              child: Stack(
                alignment: AlignmentDirectional(-3.0, -3.0),
                children: <Widget>[
                  Icon(Icons.menu, color: Colors.white),
                ],
              ),
            ),
          ),*/
         //App title
          Image.asset(
            'assets/img/logo_circle_white_bk.png',
            width: 60,
            height: 600,
          ),

          SizedBox(width: 8)
          ///  Notification Icon
         /* InkWell(
            onTap: () {
              Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => TestScreen()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(4),
              child: Stack(
                alignment: AlignmentDirectional(-3.0, -3.0),
                children: <Widget>[
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  CountNotice == '0'
                      ? Container()
                      : CircleAvatar(
                    radius: 8.6,
                    backgroundColor: Colors.amber,
                    child: Text(
                      CountNotice,
                      style:
                      TextStyle(fontSize: 13.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }


}
