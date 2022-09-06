import 'dart:developer';
import 'package:amuzic/database/db_functions.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/main.dart';
import 'package:amuzic/screens/home_screen.dart';
import 'package:amuzic/screens/login_screen.dart';
import 'package:amuzic/theme/app_theme.dart';

class SplashSreen extends StatefulWidget {
  const SplashSreen({Key? key}) : super(key: key);

  @override
  State<SplashSreen> createState() => _SplashSreenState();
}

bool islogin = false;
var username = '';

class _SplashSreenState extends State<SplashSreen> {
  late bool lTheme;
  @override
  void initState() {
    fetchSongs();
    //
    navigateFromSplash(context);
    //
    lTheme = preferences.getBool("theme") ?? true;
    //implement initState
    super.initState();
  }

  //
  final myBox = Mybox.getinstance();
  // final myPlayer = AssetsAudioPlayer.withId('0');
  final _audioQuerry = OnAudioQuery();
  //
  List<Audio> audioSongs = [];
  List<SongModel> fetchedSongs = [];
  List<SongModel> allSongs = [];
  List<LocalStorageSongs> dbSongs = [];
  List<LocalStorageSongs> mappedSongs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTheme.splashText(text: 'AMUZ', color: MyTheme.red),
              MyTheme.splashText(
                  text: 'IC', color: !lTheme ? MyTheme.blueDark : Colors.white),
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
  void fetchSongs() async {
    bool permissionStatus = await _audioQuerry.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuerry.permissionsRequest();
    }
    fetchedSongs = await _audioQuerry.querySongs();
    //
    for (var element in fetchedSongs) {
      if (element.fileExtension == 'mp3') {
        allSongs.add(element);
      }
    }
    //mapped songs
    mappedSongs = allSongs
        .map(
          (song) => LocalStorageSongs(
              title: song.title,
              artist: song.artist,
              uri: song.uri,
              duration: song.duration,
              id: song.id),
        )
        .toList();
    //
    await myBox!.put("musics", mappedSongs);
    if (myBox!.keys.contains("musics")) {
      log('musics is saved but fav didnt');
    }
    if (myBox!.keys.contains("favorites")) {
      log('My bad');
    }
    if (myBox!.keys.contains("favourites")) {
      log('just testing ');
    }
    dbSongs = myBox!.get("musics") as List<LocalStorageSongs>;
    //
    for (var element in dbSongs) {
      audioSongs.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist,
          ),
        ),
      );
    }
    //test-log
    log('the length is ${audioSongs.length}');
  }

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
            ? LoginScreen(
                allSongs: audioSongs,
              )
            : HomeScreen(userName: username, allSongs: audioSongs),
      ),
    );
  }
}
