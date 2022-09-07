import 'dart:developer';

import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/main.dart';
import 'package:amuzic/widgets/buttons.dart';
import 'package:amuzic/widgets/settings_dlg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isThemeSwitched;
  late bool isNotifySwitched;

  setNotify() async {
    isNotifySwitched = !isNotifySwitched;
    await preferences.setBool(
      "notification",
      isNotifySwitched,
    );
    setState(() {});
  }

  @override
  void initState() {
    isNotifySwitched = preferences.getBool("notification") ?? true;
    isThemeSwitched = preferences.getBool("theme") ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    setTheme() async {
      isThemeSwitched = !isThemeSwitched;

      DynamicTheme.of(context)!.setTheme(
          isThemeSwitched ? MyTheme.darkThemeId : MyTheme.lightThemeId);
      await preferences.setBool("theme", isThemeSwitched);
    }

    var size = MediaQuery.of(context).size;

    settingsTile({
      required String text,
      required IconData icon,
    }) =>
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => SettingsDlg(title: text));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: size.width * 0.2,
            decoration: BoxDecoration(
                color: lTheme ? Colors.white : MyTheme.d_base,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [MyFont.myBoxShadow()]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: lTheme ? Colors.black : MyTheme.d_light,
                ),
                MyFont.montSemiBold16(text),
                const Icon(
                  Icons.circle,
                  color: Colors.black,
                  size: 4,
                )
              ],
            ),
          ),
        );

    return Scaffold(
      backgroundColor: lTheme ? MyTheme.light : MyTheme.d_blueDark,
      appBar: AppBar(
        toolbarHeight: 30,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SlideInLeft(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MyFont.montBold24Red('S'),
                    MyFont.montBold24('ETTINGS', context),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        MyFont.myClick();
                        await setTheme();
                        setState(() {});
                      },
                      child: Container(
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: lTheme ? Colors.white : MyTheme.d_base,
                            boxShadow: [MyFont.myBoxShadow()]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: lTheme
                                              ? Colors.black
                                              : MyTheme.d_light)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: isThemeSwitched
                                        ? FlipInY(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            key: const Key('dark'),
                                            child: Icon(
                                              Icons.dark_mode,
                                              color: lTheme
                                                  ? MyTheme.blueDark
                                                  : MyTheme.d_light,
                                              size: 30,
                                            ),
                                          )
                                        : FlipInY(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            key: const Key('light'),
                                            child: Icon(
                                              Icons.light_mode,
                                              color: MyTheme.blueDark,
                                              size: 30,
                                            ),
                                          ),
                                  ),
                                ),
                                Switch(
                                  value: isThemeSwitched,
                                  onChanged: (value) {
                                    setTheme();
                                    setState(() {});
                                  },
                                  inactiveTrackColor: Colors.grey,
                                  activeTrackColor: Colors.grey.shade800,
                                  activeColor: MyTheme.red,
                                  inactiveThumbColor: Colors.black,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    !isThemeSwitched
                                        ? MyFont.montSemiBold13(
                                            "SWITCH TO DARK")
                                        : MyFont.montSemiBold13(
                                            "SWITCH TO LIGHT"),
                                    MyFont.montLight10("Change Your Theme"),
                                  ],
                                ),
                                const SizedBox()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        MyFont.myClick();
                        setNotify();
                        log(preferences.getBool("notification").toString());
                      },
                      child: Container(
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: lTheme ? Colors.white : MyTheme.d_base,
                            boxShadow: [MyFont.myBoxShadow()]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: lTheme
                                              ? Colors.black
                                              : MyTheme.d_light)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: isNotifySwitched
                                        ? FlipInY(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            key: const Key('dark'),
                                            child: Icon(
                                              Icons
                                                  .notifications_active_outlined,
                                              color: MyTheme.d_light,
                                              size: 30,
                                            ),
                                          )
                                        : FlipInY(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            key: const Key('light'),
                                            child: Icon(
                                              Icons.notifications_off,
                                              color: MyTheme.blueDark,
                                              size: 30,
                                            ),
                                          ),
                                  ),
                                ),
                                Switch(
                                  value: isNotifySwitched,
                                  onChanged: (value) async {
                                    await setNotify();
                                  },
                                  inactiveTrackColor: Colors.grey,
                                  activeTrackColor: Colors.grey.shade800,
                                  activeColor: MyTheme.red,
                                  inactiveThumbColor: Colors.black,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFont.montSemiBold13("NOTIFICATIONS"),
                                    MyFont.montLight10("Switch Notifications"),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () async {
                      await Share.share("Hey Tryout this new Music Player");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: size.width * 0.2,
                      decoration: BoxDecoration(
                          color: lTheme ? Colors.white : MyTheme.d_base,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [MyFont.myBoxShadow()]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.red)),
                            child: const Icon(
                              Icons.share,
                              color: Colors.red,
                            ),
                          ),
                          MyFont.montSemiBold16('SHARE THIS APP'),
                          const Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 4,
                          )
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
                settingsTile(
                  text: 'TERMS & CONDITIONS',
                  icon: Icons.assignment,
                ),
                const SizedBox(
                  height: 30,
                ),
                settingsTile(text: "PRIVACY POLICY", icon: Icons.policy),
                const SizedBox(
                  height: 30,
                ),
                settingsTile(
                  text: "ABOUT US",
                  icon: Icons.info,
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: MyBackButton(context: context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
