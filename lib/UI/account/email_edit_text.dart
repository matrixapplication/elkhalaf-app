import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class EmailEditText extends StatelessWidget {
  final Function? updateEmail;
  final String? value;

  EmailEditText({this.updateEmail, this.value});

  @override
  Widget build(BuildContext context) {
    String emailPlaceHolder = YemString.email;
    String emailHint = YemString.email_hint;
    String emailOnError = YemString.email_error;

    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
            border: InputBorder.none,
          errorStyle: TextStyle(),
          labelStyle: TextStyle(),
          hintStyle: TextStyle(),
          hintText: emailHint,
            prefixIcon: Material(
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Icon(
                Icons.email,
                color: kPrimaryColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)       ),
        keyboardType: TextInputType.emailAddress,
        validator: (text) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(text!);
       return emailValid ? null : emailOnError;
          // return null;
        },
        onSaved: updateEmail as void Function(String?)?,
      ),
    );
  }
}
