import 'package:amuzic/core/theme/app_theme.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFont {
  static montBold36(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 36,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold20(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold18(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold24(String text, BuildContext context) {
    final theme = DynamicTheme.of(context)!.themeId == 0 ? true : false;
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: theme ? Colors.black : Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold20White(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold20Grey(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 20,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold20Red(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 20,
        color: Colors.red,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold24Red(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        color: Color.fromRGBO(198, 31, 38, 1),
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montSemiBold13(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montSemiBold16(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montSemiBold13White(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontFamily: "Montserrat",
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montSemiBold10(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montSemiBold10grey(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.grey.shade600,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold16(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold16A(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold16White(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: "Montserrat",
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold16Red(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: MyTheme.red,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montBold8(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 8,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static montRegular10(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static montLight10(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static montLight10Left(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 10,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static montMedium13(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: "Montserrat",
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static montMedium13White(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: "Montserrat",
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static montMedium8(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Montserrat",
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
