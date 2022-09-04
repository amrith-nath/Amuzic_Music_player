import 'dart:developer';

import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/main.dart';
import 'package:amuzic/widgets/settings_dlg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isThemeSwitched = false;
  late bool isNotifySwitched;

  setNotify() async {
    isNotifySwitched = isNotifySwitched ? false : true;
    await preferences.setBool(
      "notification",
      isNotifySwitched,
    );
    setState(() {});
  }

  @override
  void initState() {
    isNotifySwitched = preferences.getBool("notification") ?? true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SlideInLeft(
          duration: Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MyFont.montBold24Red('S'),
                    MyFont.montBold24('ETTINGS'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        MyFont.myClick();
                        setState(() {
                          isThemeSwitched = isThemeSwitched ? false : true;
                        });
                      },
                      child: Container(
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
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
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: isThemeSwitched
                                        ? FlipInY(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            key: const Key('dark'),
                                            child: Icon(
                                              Icons.dark_mode,
                                              color: MyTheme.blueDark,
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
                                    setState(() {
                                      isThemeSwitched =
                                          isThemeSwitched ? false : true;
                                    });
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
                            color: Colors.white,
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
                                      border: Border.all(color: Colors.black)),
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
                                              color: MyTheme.blueDark,
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
                                    log(isNotifySwitched.toString());
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
                          color: Colors.white,
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
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              SettingsDlg(title: "TERMS & CONDITIONS"));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: size.width * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [MyFont.myBoxShadow()]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.assignment,
                            color: Colors.black,
                          ),
                          MyFont.montSemiBold16('TERMS & CONDITIONS'),
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
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              SettingsDlg(title: "PRIVACY POLICY"));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: size.width * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [MyFont.myBoxShadow()]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.policy,
                            color: Colors.black,
                          ),
                          MyFont.montSemiBold16('PRIVACY POLICY'),
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
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => SettingsDlg(title: "ABOUT US"));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: size.width * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [MyFont.myBoxShadow()]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.info,
                            color: Colors.black,
                          ),
                          MyFont.montSemiBold16('ABOUT US'),
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
                  height: 50,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      MyFont.myClick();
                      Navigator.pop(context);
                    },
                    child: ZoomIn(
                      // duration: Duration(milliseconds: 500),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyTheme.blueDark,
                        ),
                        width: 60,
                        height: 60,
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
