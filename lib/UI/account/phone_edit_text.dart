import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class PhoneEditText extends StatelessWidget {
  final Function? updatePhone;
  final String? value;
  PhoneEditText({this.updatePhone, this.value});

  @override
  Widget build(BuildContext context) {
    String phonePlaceHolder =YemString.phone;
    String phoneHint = YemString.phoneHint;

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
          hintText: phoneHint,
            prefixIcon: Material(
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Icon(
                Icons.phone,
                color: kPrimaryColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)
        ),
        keyboardType: TextInputType.phone,
        validator: (text) {
          bool isItShort = text!.length > 6;
//        return isItShort ? null : phoneOnError;
        return null;
        },
        onSaved: updatePhone as void Function(String?)?,
      ),
    );
  }
}
