import 'dart:developer';

import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/main.dart';
import 'package:amuzic/screens/play_screen.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PlaySong {
  List<Audio> fullSongs;
  int index;

  final box = Mybox.getinstance();
  List<LocalStorageSongs> myRecentSongs = [];

  PlaySong({required this.fullSongs, required this.index});
  final AssetsAudioPlayer myPlayer = AssetsAudioPlayer.withId('0');
  bool? notify;
  startPlay() async {
    notify = preferences.getBool("notification") ?? true;
    myPlayer.open(
      Playlist(
        audios: fullSongs,
        startIndex: index,
      ),
      showNotification: notify!,
      notificationSettings: const NotificationSettings(
        stopEnabled: false,
      ),
      autoStart: true,
      loopMode: LoopMode.playlist,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      playInBackground: PlayInBackground.enabled,
    );
    myRecentSongs = box!.get("recent") as List<LocalStorageSongs>;
    final song = getSong(fullSongs[index]);
    await addSong(song);
  }

  shuffle() {
    myPlayer.shuffle;
  }

  repeat() {
    myPlayer.loopMode;
  }

  getSong(Audio song) {
    final recentSong = LocalStorageSongs(
        title: song.metas.title,
        artist: song.metas.artist,
        uri: song.path,
        duration: 0,
        id: int.parse(song.metas.id!));

    return recentSong;
  }

  addSong(LocalStorageSongs song) async {
    int flag = 0;
    if (myRecentSongs.length >= 10) myRecentSongs.removeAt(0);

    for (var element in myRecentSongs) {
      if (element.uri == song.uri) {
        flag++;
      }
    }
    if (flag == 0) {
      myRecentSongs.add(song);
      await box!.put("recent", myRecentSongs);
    }

    // recentTemp.add(song);
    // log(recentTemp.length.toString());
  }
}

class Play {
  static goToNowPlaying(
    BuildContext context,
    List<Audio> fullsong,
  ) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop,
            child: PlayScreen(
              fullsong: fullsong,
            )));
  }
}
