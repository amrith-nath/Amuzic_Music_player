import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:xen_popup_card/xen_card.dart';

class SettingsDlg extends StatelessWidget {
  SettingsDlg({required this.title, Key? key}) : super(key: key);

  String? title;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return XenPopupCard(
        cardBgColor: lTheme ? MyTheme.light : MyTheme.d_light,
        appBar: XenCardAppBar(
            color: lTheme ? MyTheme.blueDark : MyTheme.d_blueDark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyFont.montSemiBold13White(title!),
              ],
            )),
        body: Center(
          child: MyFont.montBold16Red("TODO"),
        ));
  }
}
