import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class EditTextPhone extends StatelessWidget {
  final Function? updatePhone;
  final bool showRequired;

  EditTextPhone({this.updatePhone, this.showRequired = false});

  @override
  Widget build(BuildContext context) {
    String phonePlaceHolder = YemString.phoneHolder;
    String phoneHint = YemString.phoneHint;
    String phoneOnError9 = YemString.phoneOnError9;
    String phoneOnError10 = YemString.phoneOnError10;
    String? validate(text) {
      if(text.toString().startsWith('0')){
        return text.length == 10  ? null : phoneOnError10;
      }else{
        return text.length == 9  ? null : phoneOnError9;
      }

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
//          labelText: phonePlaceHolder,
          hintText: phoneHint,
          prefixIcon: Material(
            elevation: 0,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Icon(
              Icons.phone,
              color: kPrimaryColor,
            ),
          ),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 25, vertical: 13)
        ),
        keyboardType: TextInputType.phone,
        validator: (text) {
          return validate(text);
        },
        onSaved: updatePhone as void Function(String?)?,
      ),
    );
  }
}
