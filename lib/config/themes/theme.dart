import 'package:flutter/material.dart';
import '../constants/constants_color.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    appBarTheme: appBarTheme,
  );
}

ThemeData darkThemeData(BuildContext context) {

  return ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    appBarTheme: appBarTheme,
  );

  // return ThemeData.dark(useMaterial3: true).copyWith(
  //   primaryColor: kPrimaryColor,
  //   scaffoldBackgroundColor: kDarkGreyColor,
  //   colorScheme: ColorScheme.dark(
  //     primary: kPrimaryColor,
  //     secondary: kSecondaryColor,
  //     error: kErrorColor,
  //   ),
  //   appBarTheme: appBarTheme.copyWith(
  //     backgroundColor: kDarkGreyColor,
  //     iconTheme: IconThemeData(color: kWhiteColor),
  //   ),
  // );

}

const appBarTheme = AppBarTheme(
  centerTitle: false,
  elevation: 0,
  backgroundColor: kWhiteColor,
  iconTheme: IconThemeData(color: kPrimaryColor),
  titleTextStyle: TextStyle(
    color: kDarkColor,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  ),
);
