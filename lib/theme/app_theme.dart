import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  //*Colors//
  //
  static var red = const Color.fromRGBO(198, 31, 38, 1);
  static var blueDark = const Color.fromRGBO(43, 45, 66, 1);
  static var light = const Color.fromRGBO(237, 242, 244, 1);
  static var dark = const Color.fromRGBO(20, 20, 23, 1);
  //
  //
  static var lightTheme = ThemeData(
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    primarySwatch: Colors.red,
    backgroundColor: light,
    scaffoldBackgroundColor: light,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: MyTheme.blueDark,
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    dividerColor: Colors.black,
    dividerTheme: const DividerThemeData(color: Colors.black),
  );
  //
  //
  static var darkTheme = ThemeData(
    primarySwatch: Colors.red,
    backgroundColor: dark,
    scaffoldBackgroundColor: dark,
    iconTheme: IconThemeData(
      color: blueDark,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: MyTheme.blueDark,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
    dividerColor: Colors.black,
    dividerTheme: const DividerThemeData(color: Colors.black),
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
