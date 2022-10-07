import 'dart:developer';
import 'package:amuzic/core/functions/get_songs.dart';
import 'package:amuzic/domine/database/database_model.dart';
import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:amuzic/main.dart';
import 'package:amuzic/presentation/screens/home_screen/home_screen.dart';
import 'package:amuzic/presentation/screens/login_screen/login_screen.dart';
import 'package:amuzic/core/theme/app_theme.dart';

bool islogin = false;
var username = '';

class SplashSreen extends StatelessWidget {
  SplashSreen({Key? key}) : super(key: key);

  late bool lTheme;

  //
  // final myPlayer = AssetsAudioPlayer.withId('0');
  //

  getSongs() async {
    await GetSongs.fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateFromSplash(context);
      lTheme = preferences.getBool("theme") ?? true;
      getSongs();
    });

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTheme.splashText(text: 'AMUZIC', color: MyTheme.red),
            ],
          ),
          const SizedBox(
            child: Text(
              'Version 2.0',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      )),
    );
  }

  //

  //
  void navigateFromSplash(context) async {
    final islogintemp = preferences.getBool('isLogin');
    if (islogintemp != null) {
      islogin = islogintemp;
    }
    final userNametemp = preferences.getString('user_name');
    if (userNametemp != null) {
      username = userNametemp;
    }
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => !islogin
            ? LoginScreen()
            : HomeScreen(
                userName: username,
              ),
      ),
    );
  }
}
