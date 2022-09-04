import 'dart:math';

import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/screens/search_screen.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

//*drawerButton//
class DrawerButton extends StatelessWidget {
  const DrawerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            color: MyTheme.blueDark,
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
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            color: MyTheme.blueDark,
          ),
          width: 60,
          height: 60,
          child: const Icon(
            Icons.search_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
