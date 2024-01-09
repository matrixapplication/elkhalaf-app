import 'package:alkhalafsheep/const/_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditText extends StatelessWidget {
  final Function? updateFunc;
  final Function? validateFunc;
  final IconData iconData;
  final String? suffixText;
  final String hint;
  final String value;
  final int lines;
  final double fontSize;
  final bool enable;
  final Color color;
  final Color backgroundColor;
  final Color hintColor;
  final AutovalidateMode? autoValidate;
  final TextInputType type;
  final List<TextInputFormatter>? formatter;

  EditText({
    this.autoValidate,
    this.updateFunc,
    this.backgroundColor = ACCENT_COLOR_DARK ,
    this.validateFunc,
    required this.iconData,
    required this.value,
    this.fontSize = 14,
    required this.hint,
    this.suffixText,
    this.color = PRIMARY_COLOR,
    this.hintColor = Colors.white,
    this.lines = 1,
    this.enable = true,
    this.formatter,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: color, width: 0.4),
      ),
      child: TextFormField(
        autovalidateMode: autoValidate ?? AutovalidateMode.disabled,
        initialValue: value,
        style: TextStyle(color: color),
        decoration: InputDecoration(
            border: InputBorder.none,
            errorStyle: TextStyle(fontSize: 10, color: hintColor),
            labelStyle: TextStyle(fontSize: fontSize, color: hintColor),
            hintStyle: TextStyle(fontSize: fontSize, color: hintColor),
            labelText: hint,
            hintText: hint,
            counterStyle: TextStyle(color: Colors.green),
            suffixText: suffixText,
            prefixIcon: Icon(
              iconData,
              color: color,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        keyboardType: type,
        validator: (text) {
          if (validateFunc != null) return validateFunc!(text);
          return null;
        },
        enabled: enable,
        maxLines: lines,
        inputFormatters: formatter,
        onSaved: (newValue) {
          if (updateFunc != null) return updateFunc!(newValue);
          return ;
        },
      ),
    );
  }
}
