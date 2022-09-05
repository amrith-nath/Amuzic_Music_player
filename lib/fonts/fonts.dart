import 'package:amuzic/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFont {
  static montBold36(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static montBold20(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static montBold18(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static montBold24(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  static montBold20White(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          textStyle: const TextStyle(color: Colors.white)),
    );
  }

  static montBold20Grey(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          textStyle: TextStyle(color: Colors.grey.shade400)),
    );
  }

  static montBold20Red(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          textStyle: const TextStyle(color: Colors.white)),
    );
  }

  static montBold24Red(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          textStyle: const TextStyle(color: Color.fromRGBO(198, 31, 38, 1))),
    );
  }

  static montSemiBold13(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montSemiBold16(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montSemiBold13White(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        textStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  static montSemiBold10(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montSemiBold10grey(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          textStyle: TextStyle(color: Colors.grey.shade600)),
    );
  }

  static montBold16(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold16White(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textStyle: const TextStyle(color: Colors.white)),
    );
  }

  static montBold16Red(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textStyle: TextStyle(color: MyTheme.red)),
    );
  }

  static montBold8(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 8,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montRegular10(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static montLight10(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static montLight10Left(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static montMedium13(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static montMedium13White(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.montserrat(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          textStyle: const TextStyle(color: Colors.white)),
    );
  }

  static montMedium8(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 8,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static myBoxShadow() {
    return const BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.25),
        blurRadius: 4,
        offset: Offset(0, 4));
  }

  //*MySound
  static myClick() {
    return SystemSound.play(SystemSoundType.click);
  }
}
