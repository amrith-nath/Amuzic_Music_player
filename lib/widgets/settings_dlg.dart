import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xen_popup_card/xen_card.dart';

class SettingsDlg extends StatelessWidget {
  SettingsDlg({required this.title, Key? key}) : super(key: key);

  String? title;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    const email = "amrithnath@outlook.com";

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
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          MyFont.montBold16A(
              "This App is designed and developed by AMRITHNATH "),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: MyFont.montBold18('Contact '),
          ),
          const SizedBox(
            height: 10,
          ),
          const SelectableText(email),
          TextButton(
              onPressed: () {
                const data = ClipboardData(text: email);
                Clipboard.setData(data);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: MyFont.montMedium13('Copied to clipboard')),
                );
              },
              child: MyFont.montSemiBold13("Copy e-mail"))
        ]));
  }
}
