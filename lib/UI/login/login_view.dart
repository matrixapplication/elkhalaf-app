import 'package:flutter/material.dart';
import 'package:alkhalafsheep/UI/login/phone_edit_text.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

import 'password_edit_text.dart';

String inputPhone = '';
String inputPassword = '';

class LoginView extends StatelessWidget {
  final submitForm;
  final bool? loading;
  final scaffoldKey;
  final formKey;
  final navigateSignUp;
  final navigateForgetPassword;

  LoginView({
    @override this.loading,
    @override this.scaffoldKey,
    @override this.formKey,
    @override this.submitForm,
    @override this.navigateSignUp,
    @override this.navigateForgetPassword,
  });

  @override
  Widget build(BuildContext context) {
    double devicePixRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: loginLayout(devicePixRatio),
    );
  }

  updatePhoneOnFormSave(String text) {
    inputPhone = text;
  }

  updatePasswordOnFormSave(String text) {
    inputPassword = text;
  }

  Widget loginLayout(double devicePixRatio) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            logoHeroAnim(devicePixRatio),
            SizedBox(height: 25),
            loginFormLayout(),
          ],
        ),
      ),
    );
  }

  Hero logoHeroAnim(double devicePixRatio) {
    return Hero(
      tag: "logo",
      child: Image.asset(
        'assets/img/logo.png',
        height: 180,

      ),
    );
  }

  Widget loginFormLayout() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            loading! ? LinearProgressIndicator() : Container(),
            EditTextPhone(
              updatePhone: updatePhoneOnFormSave,
            ),
            SizedBox(
              height: 30,
            ),
            EditTextPassword(
              updatePassword: updatePasswordOnFormSave,
            ),
            textViewForgetPassword(),
            submitButton(),
            textViewSignUp(),
          ],
        ),
      ),
    );
  }

  Widget textViewForgetPassword() {
    return Container(
      alignment: Alignment.topRight,
      child: FlatButton(
        child: Text(YemString.forgetPassword, style: kGreyTextColor),
        onPressed: navigateForgetPassword,
      ),
    );
  }

  Widget submitButton() {
    return GFButton(
      color: kPrimaryColor,
      onPressed: loading!
          ? null
          : () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();
                submitForm(inputPhone, inputPassword);
              }
            },
      text: YemString.login,
      size: GFSize.LARGE,
      shape: GFButtonShape.pills,
    );
  }

  Widget textViewSignUp() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(YemString.doNotHaveAnAccount),
          Padding(
            padding: EdgeInsets.all(12),
            child: GestureDetector(
              child: Text(YemString.register, style: TextStyle(color: kPrimaryColor)),
              onTap: navigateSignUp,
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
