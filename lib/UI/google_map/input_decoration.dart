import 'package:flutter/material.dart';


InputDecoration customInputDecoration({
  required String hintText,
  IconButton? suffixIcon,
  double? borderRadius,
  String? hintFontFamily,
  TextStyle? hintStyle,
  Icon? prefixIcon,
  Color? hintColor,
  Color? borderColor,
  double? contentVerticalPadding,
  double? contentHorizontalPadding,
  FontWeight? fontWeight,
  double? fontSize,
  Color? fillColor,
  Color? prefixIconColor,
  bool? enabled,
}) {
  bool isBorderEnabled = enabled ?? true;

  return InputDecoration(
    hintText: hintText,

    hintStyle: hintStyle??TextStyle(
      color: hintColor ?? Colors.grey,
      fontSize: fontSize ?? 12,
      fontFamily: hintFontFamily,
      fontWeight: fontWeight ?? FontWeight.w400,
    ),
    enabled: enabled ?? true,
    border: isBorderEnabled ? OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? Colors.black, // Adjust the color here
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
    ) : InputBorder.none, // Use
    disabledBorder:  OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? Colors.black, // Adjust the color here
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
    ) , // Use InputBorder.none when not enabled
    enabledBorder: isBorderEnabled ? OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? Colors.black, // Adjust the color here
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
    ) : InputBorder.none, // Use InputBorder.none when not enabled
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor!, // Adjust the color here
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
    ),

    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8)),
    fillColor: fillColor??Colors.white,
    filled: true,
    contentPadding: EdgeInsets.symmetric(
        vertical: contentVerticalPadding ?? 5,
        horizontal: contentHorizontalPadding ?? 8),
    suffixIcon: suffixIcon != null
        ? Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: (suffixIcon),
    )
        : null,
    prefixIcon: prefixIcon != null
        ? Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: prefixIcon,
    )
        : null,
  );
}
