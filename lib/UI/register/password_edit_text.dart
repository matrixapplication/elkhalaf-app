import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

bool obscurePassword = true;

class EditTextPassword extends StatefulWidget {
  final Function? updatePassword;
  final  focusNodePassword;
  EditTextPassword({this.updatePassword, this.focusNodePassword});

  @override
  _EditTextPasswordState createState() => _EditTextPasswordState();
}

class _EditTextPasswordState extends State<EditTextPassword> {
  @override
  Widget build(BuildContext context) {
    String passwordPlaceHolder = YemString.password;
    String passwordHint = YemString.passwordHint;
    String passwordOnError = YemString.passwordError;
    String? validate(text) {
      bool passwordValid = text.length > 8;
      return passwordValid ? null : passwordOnError;
    }

    void changePasswordVisibility() {
      setState(() {
        obscurePassword = !obscurePassword;
      });
    }

    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: passwordPlaceHolder,
//          hintText: passwordHint,
          suffixIcon: GestureDetector(
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Icon(
                  obscurePassword ? Icons.remove_red_eye : Icons.security),
            ),
            onTap: changePasswordVisibility,
          ),
          prefixIcon: Material(
            elevation: 0,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Icon(
              Icons.lock_outline,
              color: kPrimaryColor,
            ),
          ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)   ),
        obscureText: obscurePassword,
        keyboardType: TextInputType.text,
        textInputAction:  TextInputAction.done,
        validator: (text) {
          return validate(text);
        },
        onSaved: widget.updatePassword as void Function(String?)?,
//      focusNode: widget.focusNodePassword,

      ),
    );
  }
}
