import 'package:alkhalafsheep/const/_const.dart';
import 'package:flutter/material.dart';

bool obscurePassword = true;

class EditTextPassword extends StatefulWidget {
  final Function? updatePassword;
  final bool autoValidate;
  final Function? validateFunc;
  final String hint;
  final String? value;

  EditTextPassword(
      {required this.hint,
      this.updatePassword,
      this.autoValidate = false,
      this.value,
      this.validateFunc});

  @override
  _EditTextPasswordState createState() => _EditTextPasswordState();
}

class _EditTextPasswordState extends State<EditTextPassword> {
  @override
  Widget build(BuildContext context) {
    void changePasswordVisibility() {
      setState(() {
        obscurePassword = !obscurePassword;
      });
    }

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: PRIMARY_COLOR, width: 0.4),
      ),
      child: TextFormField(
        autovalidate: widget.autoValidate,
        initialValue: widget.value,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(

            border: InputBorder.none,
            errorStyle: TextStyle(fontSize: 10, color: Colors.white),
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            labelText: widget.hint,
            hintText: widget.hint,
            suffixIcon: GestureDetector(
              child: Icon(
                obscurePassword ? Icons.remove_red_eye : Icons.security,
                color: PRIMARY_COLOR,
              ),
              onTap: changePasswordVisibility,
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: PRIMARY_COLOR,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        obscureText: obscurePassword,
        keyboardType: TextInputType.text,
        validator: widget.validateFunc as String? Function(String?)?,
        onSaved: widget.updatePassword as void Function(String?)?,
      ),
    );
  }
}
