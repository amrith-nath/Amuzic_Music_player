import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/presentation/screens/home_screen/widgets/home.dart';
import 'package:amuzic/presentation/screens/home_screen/widgets/drawer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({required this.userName, Key? key}) : super(key: key);
  String userName;

  bool isSearchOn = false;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 20,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: lTheme ? MyTheme.light : MyTheme.d_blueDark,
      ),
      drawer: Mydrawer(
        username: userName,
      ),
      body: MyHome(
        userName: userName,
      ),
    );
  }
}
