import 'dart:math';

import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/presentation/screens/search_screen/search_screen.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

//*drawerButton//
class DrawerButton extends StatelessWidget {
  const DrawerButton({required this.context, Key? key}) : super(key: key);
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return SlideInLeft(
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () {
          MyFont.myClick();
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lTheme ? MyTheme.blueDark : MyTheme.d_light,
          ),
          width: 60,
          height: 60,
          child: Transform.rotate(
            angle: (90 / (180 / pi)),
            child: const Icon(
              Icons.bar_chart_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

//*search_button//

class SearchButton extends StatelessWidget {
  const SearchButton({required this.context, Key? key}) : super(key: key);
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return SlideInLeft(
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () {
          MyFont.myClick();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const SearchScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lTheme ? MyTheme.blueDark : MyTheme.d_light,
          ),
          width: 60,
          height: 60,
          child: const Icon(
            Icons.manage_search_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//*search_button//

class MyBackButton extends StatelessWidget {
  const MyBackButton({required this.context, this.icon, this.color, Key? key})
      : super(key: key);
  final BuildContext context;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return GestureDetector(
      onTap: () {
        MyFont.myClick();
        Navigator.pop(context);
      },
      child: SlideInRight(
        // duration: Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lTheme ? MyTheme.blueDark : color ?? MyTheme.d_light,
          ),
          width: 60,
          height: 60,
          child: Icon(
            icon ?? Icons.chevron_left_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
