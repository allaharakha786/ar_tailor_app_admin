import 'package:flutter/material.dart';

import '../constants/colors_resources.dart';
import '../constants/dimentions_resources.dart';
import '../constants/string_resources.dart';

class CustomTextStyles {
  static TextStyle detailsTextStyle(Color color) {
    return TextStyle(
        fontFamily: StringResources.SEGO_REGULAR,
        fontWeight: FontWeight.bold,
        fontSize: DimensionsResource.FONT_SIZE_SMALL,
        color: color);
  }

  static TextStyle titleTextStyle(Color color) {
    return TextStyle(
        fontFamily: StringResources.SEGO_REGULAR,
        fontWeight: FontWeight.bold,
        fontSize: DimensionsResource.FONT_SIZE_MEDIUM,
        color: color);
  }

  static TextStyle elevatedTextButtonStyle(Color color) {
    return TextStyle(
        letterSpacing: 1,
        fontFamily: StringResources.POPPINS_REGULAR,
        color: color,
        fontSize: DimensionsResource.FONT_SIZE_2X_EXTRA_MEDIUM);
  }

  static TextStyle customStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorsResources.WHITE_COLOR,
        fontSize: DimensionsResource.FONT_SIZE_2X_EXTRA_LARGE);
  }

  static TextStyle textButtonStyle(var color) {
    return TextStyle(
        letterSpacing: 1,
        fontFamily: StringResources.POPPINS_REGULAR,
        color: color,
        fontSize: DimensionsResource.FONT_SIZE_SMALL);
  }

  static TextStyle contentTextStyle(Color color) {
    return TextStyle(
        fontSize: DimensionsResource.FONT_SIZE_MEDIUM,
        color: color,
        fontFamily: StringResources.SEGO_REGULAR);
  }
}
