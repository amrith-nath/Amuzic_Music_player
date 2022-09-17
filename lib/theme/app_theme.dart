// ignore_for_file: non_constant_identifier_names

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

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
  static var d_red = const Color(0xFFd1342f);
  static var d_blueDark = const Color(0xFF1a181a);
  static var d_light = const Color(0xFF505050);
  static var d_dark = const Color(0xFF434038);
  static var d_base = const Color(0xFF0a0a0a);
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
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      onSurface: MyTheme.red,
    )),
    appBarTheme: AppBarTheme(
      color: MyTheme.light,
    ),
    colorScheme: const ColorScheme.light(),
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
    appBarTheme: AppBarTheme(color: MyTheme.d_blueDark),
    colorScheme: const ColorScheme.dark(),
    primarySwatch: Colors.red,
    backgroundColor: d_blueDark,
    scaffoldBackgroundColor: d_light,
    iconTheme: IconThemeData(
      color: blueDark,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: MyTheme.d_blueDark,
      textStyle: TextStyle(
        color: d_base,
      ),
    ),
    dividerColor: d_light,
    dividerTheme: DividerThemeData(color: d_light),
  );
  //
  //*Fonts//

  static splashText({required String text, required Color color}) => Text(
        text,
        style: TextStyle(
          fontFamily: "Montserrat",
          color: color,
          fontSize: 64,
          fontWeight: FontWeight.w600,
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
