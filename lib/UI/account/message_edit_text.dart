import 'package:flutter/material.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';

class MessageEditText extends StatelessWidget {
  final void Function(String? x)? updateMessage;

  MessageEditText({this.updateMessage});

  @override
  Widget build(BuildContext context) {
    String MessagePlaceHolder = YemString.message;
    String MessageHint = YemString.message_hint;
    String MessageOnError = YemString.messager_error;

    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: TextFormField(
        minLines: 6,
        maxLines: 7,
        decoration: InputDecoration(
            border: InputBorder.none,
            errorStyle: TextStyle(),
            hintStyle: TextStyle(),
            labelText: MessagePlaceHolder,
            hintText: MessageHint,
            prefixIcon: Material(
              elevation: 0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Icon(
                Icons.comment,
                color: kPrimaryColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        keyboardType: TextInputType.multiline,
        validator: (text) {
          bool MessageValid = text!.length > 1;
          return MessageValid ? null : MessageOnError;
        },
        onSaved: updateMessage,
      ),
    );
  }
}
