import 'package:flutter/material.dart';

const LinearGradient SIGNUP_CIRCLE_BUTTON_BACKGROUND = LinearGradient(
  tileMode: TileMode.clamp,
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.4, 1],
  colors: [Colors.black, Colors.black54],
);
