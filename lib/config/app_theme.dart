import 'package:flutter/material.dart';
import '../utils/colors_util.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    errorColor: ColorsUtil.error,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Roboto",
    primarySwatch: Colors.red,
    backgroundColor: ColorsUtil.black,
    scaffoldBackgroundColor: ColorsUtil.black,
    appBarTheme: AppBarTheme.of(context).copyWith(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorsUtil.white),
      titleTextStyle: TextStyle(
        color: ColorsUtil.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme:  TextTheme(
      titleLarge: TextStyle(fontSize: 24, color: ColorsUtil.white, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16, color: ColorsUtil.white, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 12, color: ColorsUtil.white),
    ),
  );
}
