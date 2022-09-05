// ignore_for_file: non_constant_identifier_names

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  //*Colors-lightt//
  //
  static var red = const Color.fromRGBO(198, 31, 38, 1);
  static var blueDark = const Color.fromRGBO(43, 45, 66, 1);
  static var light = const Color.fromRGBO(237, 242, 244, 1);
  static var dark = const Color.fromRGBO(20, 20, 23, 1);
  static var base = Colors.white;
  //
  //*Colors-dark//
  static var d_red = const Color.fromRGBO(198, 31, 38, 1);
  static var d_blueDark = const Color.fromRGBO(15, 52, 96, 1);
  static var d_light = const Color.fromRGBO(83, 52, 131, 1);
  static var d_dark = const Color.fromRGBO(22, 33, 62, 1);
  static var d_base = Colors.black;
//

  static const int lightThemeId = 0;
  static const int darkThemeId = 1;

  static final themeCollection = ThemeCollection(
    themes: {
      MyTheme.lightThemeId: MyTheme.lightTheme,
      MyTheme.darkThemeId: MyTheme.darkTheme,
    },
    fallbackTheme: MyTheme.lightTheme,
  );

//*light---------->
  static var lightTheme = ThemeData(
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    primarySwatch: Colors.red,
    backgroundColor: light,
    scaffoldBackgroundColor: light,
    iconTheme: IconThemeData(
      color: base,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: MyTheme.blueDark,
      textStyle: TextStyle(
        color: d_base,
      ),
    ),
    dividerColor: Colors.black,
    dividerTheme: const DividerThemeData(color: Colors.black),
  );
  //
  //
  //*dark---------->
  static var darkTheme = ThemeData(
    primarySwatch: Colors.red,
    backgroundColor: d_dark,
    scaffoldBackgroundColor: d_dark,
    iconTheme: IconThemeData(
      color: blueDark,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: MyTheme.d_blueDark,
      textStyle: TextStyle(
        color: d_base,
      ),
    ),
    dividerColor: d_base,
    dividerTheme: DividerThemeData(color: d_base),
  );
  //
  //*Fonts//

  static splashText({required String text, required Color color}) => Text(
        text,
        style: GoogleFonts.rajdhani(
          fontSize: 64,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      );

  //*boxshadow//
  static myBoxShadow() {
    return const BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.25),
        blurRadius: 4,
        offset: Offset(0, 4));
  }
}
