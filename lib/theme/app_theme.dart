/*
 * @Description: app主题
 * @Author: iamsmiling
 * @Date: 2021-09-18 16:02:00
 * @LastEditTime: 2021-09-18 16:28:10
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ty_flutter_cli/res/R.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
      primaryColor: R.color.primary,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: R.color.white,
          elevation: .5,
          titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333))),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(selectedItemColor: R.color.primary),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          focusedBorder: InputBorder.none
          // enabledBorder: UnderlineInputBorder(
          //     borderSide:
          //         BorderSide(color: R.color.textFieldBorder, width: .5)),
          // focusedBorder: UnderlineInputBorder(
          //     borderSide:
          //         BorderSide(color: R.color.textFieldBorder, width: .5)),
          // border: UnderlineInputBorder(
          //     borderSide:
          //         BorderSide(color: R.color.textFieldBorder, width: .5))
          ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        foregroundColor: MaterialStateProperty.all(R.color.textButton),
        textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              padding:
                  MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5)),
              foregroundColor: MaterialStateProperty.all(R.color.white),
              textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return R.color.primary.withOpacity(.4);
                }
                return R.color.primary;
              }))));

  static ThemeData dartTheme = lightTheme;
}
