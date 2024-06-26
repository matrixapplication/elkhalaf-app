import 'package:flutter/material.dart';


class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final double? borderRadius;
  final Color? fontColor;
  final Color? loadingColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool? isLoading;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.borderRadius,
    this.fontColor,
    this.fontSize,
    this.borderColor,
    this.backgroundColor,this.height, this.width, this.isLoading, this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width??MediaQuery.of(context).size.width*0.4,height?? 40), // Set your desired width and height
          elevation: 0,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        child:
        Text(
          buttonText,
          style: TextStyle(
            color: fontColor?? Colors.white,
            fontSize: fontSize ?? 13,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w700,
          ),
        ),
            ),
      );
  }
}
