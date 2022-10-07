import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/presentation/screens/favourites_screen/favourites_screen.dart';
import 'package:amuzic/presentation/screens/playlist_screen/playlist_screen.dart';
import 'package:amuzic/presentation/screens/resent_songs/recent_songs.dart';
import 'package:amuzic/presentation/screens/settings_screen/settings_screen.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Mydrawer extends StatefulWidget {
  Mydrawer({required this.username, Key? key}) : super(key: key);

  String? username;

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

bool isThemeSwitched = false;

class _MydrawerState extends State<Mydrawer> {
  @override
  build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    TextStyle drawerTextStyle({
      required bool theme,
      required Color color1,
      required Color color2,
    }) =>
        TextStyle(
            color: theme ? color1 : color2,
            fontFamily: "Rajdhani",
            fontSize: 64,
            fontWeight: FontWeight.w500);
    // GoogleFonts.rajdhani(
    //   fontSize: 64,
    //   fontWeight: FontWeight.w500,
    //   color: theme ? color1 : color2,
    // );

    CircleAvatar drawerAvatar({
      required Color color,
      required IconData icon,
    }) =>
        CircleAvatar(
          backgroundColor: color,
          radius: 25,
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        );

    ListTile drawerListTile({
      required CircleAvatar leading,
      required String title,
      required Widget child,
    }) =>
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  type: PageTransitionType.rightToLeft,
                  child: child,
                ));
            Scaffold.of(context).closeDrawer();
          },
          leading: leading,
          title: MyFont.montSemiBold13(title),
          trailing: const Icon(Icons.chevron_right_rounded),
          style: ListTileStyle.drawer,
        );

    return Drawer(
      // backgroundColor: const Color.fromRGBO(43, 45, 66, 1),
      backgroundColor: lTheme ? MyTheme.light : MyTheme.d_blueDark,
      width: MediaQuery.of(context).size.width / 1.29,
      elevation: 10,
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
                decoration: BoxDecoration(
                  color: lTheme ? Colors.white : MyTheme.d_base,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'A',
                            style: drawerTextStyle(
                                theme: lTheme,
                                color1: MyTheme.red,
                                color2: MyTheme.d_red),
                          ),
                          Text(
                            'MUZIC',
                            style: drawerTextStyle(
                                theme: lTheme,
                                color1: MyTheme.blueDark,
                                color2: MyTheme.base),
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
            child: drawerListTile(
              child: const RecentScreen(),
              leading: drawerAvatar(
                color: MyTheme.blueDark,
                icon: Icons.history,
              ),
              title: 'RECENT SONGS',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          SlideInLeft(
            duration: const Duration(milliseconds: 350),
            child: drawerListTile(
              child: PlayListScreen(),
              leading: drawerAvatar(
                color: const Color.fromRGBO(43, 45, 66, 1),
                icon: Icons.library_music,
              ),
              title: 'PLAYLIST',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          SlideInLeft(
            duration: const Duration(milliseconds: 400),
            child: drawerListTile(
              child: const favourites(),
              leading: drawerAvatar(
                color: const Color.fromRGBO(198, 31, 38, 1),
                icon: Icons.favorite,
              ),
              title: 'FAVOURITES',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          const Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 200,
          ),
          SlideInLeft(
            duration: const Duration(milliseconds: 400),
            child: drawerListTile(
              child: const SettingsScreen(),
              leading: drawerAvatar(
                color: Colors.black54,
                icon: Icons.settings_outlined,
              ),
              title: 'Settings',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 200,
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
              child: Divider(),
            ),
          )
        ],
      ),
    );
  }
}
