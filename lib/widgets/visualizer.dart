import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';

class Visualizer extends StatelessWidget {
  Visualizer({required this.song, Key? key}) : super(key: key);

  final Audio song;

  final AssetsAudioPlayer myPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    var width = MediaQuery.of(context).size.width - 20;
    var mywidth = width / 60;
    var height = MediaQuery.of(context).size.height / 10;
    final visualizeList = List<Widget>.generate(
        13,
        (index) => MiniMusicVisualizer(
              color: lTheme ? Colors.red.shade100 : Colors.blue.shade900,
              width: mywidth,
              height: height * Random().nextDouble() + 5,
            ));

    return PlayerBuilder.current(
        player: myPlayer,
        builder: (context, nowPlaying) {
          return nowPlaying.audio.assetAudioPath.toString() ==
                  song.path.toString()
              ? PlayerBuilder.isPlaying(
                  player: myPlayer,
                  builder: (context, isPlaying) {
                    return isPlaying
                        ? Expanded(
                            child: SlideInUp(
                              duration: const Duration(milliseconds: 600),
                              key: const Key('v'),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: visualizeList,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ZoomIn(
                              duration: const Duration(milliseconds: 300),
                              key: const Key('c'),
                              child: Container(
                                height: 6,
                                color: lTheme
                                    ? Colors.red.shade400
                                    : Colors.blue.shade900,
                              ),
                            ),
                          );
                  })
              : Container();
        });
  }
}
