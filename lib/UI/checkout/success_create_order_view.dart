import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/home/home_controller.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';

class SuccessCreateOrderView extends StatelessWidget {
  static const String id = 'SuccessCreateOrder';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(HomeController.id, (route) => false);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.check_circle, color: Colors.green, size: 120),
                  Text(YemString.successCreateOrder, style: kTextGreyHeader),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 0.8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child:
                                Text(YemString.home, style: kWhiteTextHeader)),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          HomeController.id, (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
