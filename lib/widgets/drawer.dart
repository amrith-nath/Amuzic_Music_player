import 'dart:developer';

import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/screens/favourites_screen.dart';
import 'package:amuzic/screens/playlist_screen.dart';
import 'package:amuzic/screens/search_screen.dart';
import 'package:amuzic/screens/settings_screen.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/home_screen.dart';

class Mydrawer extends StatefulWidget {
  Mydrawer({required this.username, Key? key}) : super(key: key);

  String? username;

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

bool isThemeSwitched = false;

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: const Color.fromRGBO(43, 45, 66, 1),
      backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
      width: MediaQuery.of(context).size.width / 1.29,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        children: [
          SlideInDown(
            duration: const Duration(milliseconds: 400),
            child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AMUZ',
                            style: GoogleFonts.rajdhani(
                              fontSize: 64,
                              fontWeight: FontWeight.w500,
                              color: MyTheme.red,
                            ),
                          ),
                          Text(
                            'IC',
                            style: GoogleFonts.rajdhani(
                              fontSize: 64,
                              fontWeight: FontWeight.w500,
                              color: MyTheme.blueDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          SlideInLeft(
            duration: const Duration(milliseconds: 300),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                radius: 25,
                child: Icon(
                  Icons.mood_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: MyFont.montSemiBold13('FIND YOUR MOOD'),
              trailing: const Icon(Icons.chevron_right_rounded),
              style: ListTileStyle.drawer,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          SlideInLeft(
            duration: const Duration(milliseconds: 350),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      type: PageTransitionType.rightToLeft,
                      child: const PlayListScreen(),
                    ));
              },
              leading: const CircleAvatar(
                backgroundColor: Color.fromRGBO(43, 45, 66, 1),
                radius: 25,
                child: Icon(
                  Icons.library_music,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: MyFont.montSemiBold13('PLAYLIST'),
              trailing: const Icon(Icons.chevron_right_rounded),
              style: ListTileStyle.drawer,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          SlideInLeft(
            duration: const Duration(milliseconds: 400),
            child: ListTile(
              onTap: () {
                // Scaffold.of(context).closeDrawer();
                Navigator.push(
                    context,
                    PageTransition(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      type: PageTransitionType.rightToLeft,
                      child: const favourites(),
                    ));
                // Scaffold.of(context).closeDrawer();
                // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                //   return favourites();
                // }));
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (ctx) => ScreenFavourites()));
              },
              leading: const CircleAvatar(
                backgroundColor: Color.fromRGBO(198, 31, 38, 1),
                radius: 25,
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: MyFont.montSemiBold13('FAVOURITES'),
              style: ListTileStyle.drawer,
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          const Divider(
            color: Colors.black45,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 200,
          ),
          SlideInLeft(
            duration: const Duration(milliseconds: 400),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      childCurrent:
                          HomeScreen(userName: 'userName', allSongs: const []),
                      duration: const Duration(milliseconds: 350),
                      child: const SettingsScreen(),
                    ));
              },
              leading: const CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 20,
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              title: MyFont.montMedium13('Settings'),
              style: ListTileStyle.drawer,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 200,
          ),
          const Divider(
            color: Colors.black45,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          ZoomIn(
            duration: const Duration(milliseconds: 400),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [MyFont.montBold16(widget.username!)],
            )),
          ),
          ZoomIn(
            duration: const Duration(milliseconds: 400),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 50),
              child: Divider(
                color: Colors.black54,
              ),
            ),
          )
        ],
      ),
    );
  }
}
