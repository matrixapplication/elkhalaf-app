import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class NameEditText extends StatelessWidget {
  final Function? updateName;
  final String? value;

  NameEditText({this.updateName, this.value});

  @override
  Widget build(BuildContext context) {
    String namePlaceHolder = YemString.name;
    String nameHint = YemString.nameHint;
    String nameOnError = YemString.invalid_name;

    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: nameHint,
            prefixIcon: Material(
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        keyboardType: TextInputType.text,
        validator: (text) {
          return text!.length < 2 ? nameOnError : null;
        },
        onSaved: updateName as void Function(String?)?,
      ),
    );
  }
}
