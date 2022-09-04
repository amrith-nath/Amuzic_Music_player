import 'package:amuzic/theme/app_theme.dart';
import 'package:amuzic/widgets/home.dart';
import 'package:amuzic/widgets/drawer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({required this.userName, required this.allSongs, Key? key})
      : super(key: key);
  String userName;
  List<Audio> allSongs;
  bool isSearchOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 20,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: MyTheme.light,
      ),
      drawer: Mydrawer(
        username: userName,
      ),
      body: MyHome(
        userName: userName,
        allSongs: allSongs,
      ),
    );
  }
}