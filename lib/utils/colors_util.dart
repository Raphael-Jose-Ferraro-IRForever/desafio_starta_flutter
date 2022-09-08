import 'package:flutter/material.dart';

class ColorsUtil {
  static final black = getColorByHex('#000000');
  static final white = Color(0xffFFFFFF);
  static final error = Color(0xffFF0000);
  static final red = Color(0xffDD0000);

  static Color getColorByHex(String hex) {
    return Color(int.parse("0xFF${hex.replaceAll('#', '')}"));
  }
}
