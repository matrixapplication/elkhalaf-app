import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EditTextEmail extends StatelessWidget {
  final Function? updateEmail;

  EditTextEmail({this.updateEmail});

  @override
  Widget build(BuildContext context) {
    String emailPlaceHolder = 'Email address';
    String emailHint = 'Enter your email address';
    String emailOnError = 'Enter valid email address';
    String? validate(text) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(text);
      return emailValid ? null : emailOnError;
    }

    return TextFormField(
      decoration: InputDecoration(
        errorStyle: TextStyle(),
        labelStyle: TextStyle(),
        hintStyle: TextStyle(),
//        labelText: emailPlaceHolder,
        hintText: emailHint,
        icon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (text) {
        return validate(text);
      },
      onSaved: updateEmail as void Function(String?)?,
    );
  }
}
