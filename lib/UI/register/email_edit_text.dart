import 'package:flutter/material.dart';

class EditTextEmail extends StatelessWidget {
  final Function? updateEmail;
  final  focusNodePhone;
  final  focusNodeEmail;

  EditTextEmail({this.updateEmail, this.focusNodePhone, this.focusNodeEmail});

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
        labelText: emailPlaceHolder,
        hintText: emailHint,
        icon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (text) {
        return validate(text);
      },
      onSaved: updateEmail as void Function(String?)?,
      focusNode: focusNodeEmail,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (String text){
        FocusScope.of(context).requestFocus(focusNodePhone);
      },
    );
  }
}
