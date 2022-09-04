import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:xen_popup_card/xen_card.dart';

class SettingsDlg extends StatelessWidget {
  SettingsDlg({required this.title, Key? key}) : super(key: key);

  String? title;

  @override
  Widget build(BuildContext context) {
    return XenPopupCard(
        appBar: XenCardAppBar(
            color: MyTheme.blueDark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyFont.montSemiBold13White(title!),
              ],
            )),
        body: MyFont.montBold16Red("TODO"));
  }
}
