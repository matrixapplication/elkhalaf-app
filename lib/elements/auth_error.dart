import 'package:alkhalafsheep/const/_const.dart';
import 'package:alkhalafsheep/ui/login/login_controller.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class AuthErrorWidget extends StatelessWidget {
  final Function? refresh;

  AuthErrorWidget({this.refresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8),
          Icon(Icons.warning,color: Colors.orange,size: 130,),
          SizedBox(height: 8),
          Text(YemString.requireLoginMessage,style: TextStyle(color: Colors.black),),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: FlatButton(
              onPressed: (){
                Navigator.of(context).pushNamed(LoginController.id);
              },
              color: kPrimaryColor,
              child: Text(
                YemString.login,style: TextStyle(color: Colors.white),
              ),
            ),
          )

        ],
      ),
    );
  }
}
