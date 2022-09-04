import 'package:amuzic/main.dart';
import 'package:amuzic/screens/play_screen.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PlaySong {
  List<Audio> fullSongs;
  int index;

  PlaySong({required this.fullSongs, required this.index});
  final AssetsAudioPlayer myPlayer = AssetsAudioPlayer.withId('0');
  bool? notify;
  startPlay() {
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
  }

  shuffle() {
    myPlayer.shuffle;
  }

  repeat() {
    myPlayer.loopMode;
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
