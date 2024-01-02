import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class EditTextName extends StatelessWidget {
  final Function? updateName;
  final  focusNodeEmail;

  EditTextName({this.updateName, this.focusNodeEmail});

  @override
  Widget build(BuildContext context) {
    String namePlaceHolder = YemString.name;
    String nameHint = YemString.nameHint;
    String nameOnError = YemString.NameError;

    String? validate(text) {
      return text.length < 2 ? nameOnError : null;
    }

    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          errorStyle: TextStyle(),
          labelStyle: TextStyle(),
          hintStyle: TextStyle(),
//          labelText: namePlaceHolder,
          hintText: nameHint,
          counterStyle: TextStyle(color: Colors.green),
          prefixIcon: Material(
            elevation: 0,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
          ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)  ),
        keyboardType: TextInputType.text,
        validator: (text) {
          return validate(text);
        },
//        textInputAction: TextInputAction.next,
        onSaved: updateName as void Function(String?)?,
//      onFieldSubmitted: (String value) {
//        FocusScope.of(context).requestFocus(focusNodeEmail);
//      },
      ),
    );
  }
}
