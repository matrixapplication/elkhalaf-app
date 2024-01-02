import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:alkhalafsheep/UI/about_policy/about_bolicy_controller.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

import 'name_edit_text.dart';
import 'password_edit_text.dart';
import 'phone_edit_text.dart';

//String inputEmail = '';
String inputUserName = '';
String inputPhone = '';
String inputPassword = '';
String inputConfirmPassword = '';

class RegisterView extends StatelessWidget {
  final submitForm;
  final bool? loading;
  final scaffoldKey;
  final formKey;
  final navigateSignIn;

  RegisterView({
    @override this.loading,
    @override this.scaffoldKey,
    @override this.formKey,
    @override this.submitForm,
    @override this.navigateSignIn,
  });

  @override
  Widget build(BuildContext context) {
    double devicePixRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: registerLayout(devicePixRatio, context),
    );
  }

  updateUserNameOnFormSave(String text) {
    inputUserName = text;
  }

  updateUserPhoneOnFormSave(String text) {
    inputPhone = text;
  }

  updateUserConfirmPasswordOnFormSave(String text) {
    inputConfirmPassword = text;
  }

//  updateEmailOnFormSave(String text) {
//    inputEmail = text;
//  }
  updatePasswordOnFormSave(String text) {
    inputPassword = text;
  }

  Widget registerLayout(double devicePixRatio, BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            logoHeroAnim(devicePixRatio),
            SizedBox(height: 20),
            registerFormLayout(context),
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
        height: 150,
      ),
    );
  }

  Widget registerFormLayout(BuildContext context) {
    FocusNode focusNodeEmail = new FocusNode();
    FocusNode focusNodePhone = new FocusNode();
    FocusNode focusNodePassword = new FocusNode();
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            loading! ? LinearProgressIndicator() : Container(),

            EditTextName(
              updateName: updateUserNameOnFormSave,
              focusNodeEmail: focusNodeEmail,
            ),
//              EditTextEmail(
//                updateEmail: updateEmailOnFormSave,
//                focusNodePhone: focusNodePhone,
//                focusNodeEmail: focusNodeEmail,
//              ),
            SizedBox(height: 10),
            EditTextPhone(
              updatePhone: updateUserPhoneOnFormSave,
              focusNodePhone: focusNodePhone,
              focusNodePassword: focusNodePassword,
            ),
//            Text(
//              YemString.a_text_verfication_will_be_send,
//              style: kTextGreyFooter,
//            ),
            SizedBox(height: 8),
            EditTextPassword(
              updatePassword: updatePasswordOnFormSave,
              focusNodePassword: focusNodePassword,
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        AboutPolicyController(
                      pageId: '2',
                    ),
                    transitionsBuilder:
                        (context, animation1, animation2, child) =>
                            FadeTransition(opacity: animation1, child: child),
                    transitionDuration: Duration(milliseconds: 600),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  YemString.by_creating_account_u_agree_our_terms,
                  style: kTextGreyFooter,
                ),
              ),
            ),

            submitButton(),
            textViewSignUp(),
          ],
        ),
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
                submitForm(
                  name: inputUserName,
//                  email: inputEmail,
                  phone: inputPhone,
                  password: inputPassword,
                );
              }
            },
      text: YemString.register,
      size: GFSize.LARGE,
      shape: GFButtonShape.pills,
    );
  }

  Widget textViewSignUp() {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: GestureDetector(
          child: RichText(
            text: TextSpan(
              text: YemString.alreadyHaveAccount,
              style:  TextStyle(color: kPrimaryColor),
              children: <TextSpan>[
                TextSpan(
                    text: YemString.login,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          onTap: navigateSignIn,
        ),
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
