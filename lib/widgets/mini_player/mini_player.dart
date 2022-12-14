import 'dart:ui';

import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/widgets/seek-bar/seek_bar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../infrastructure/play_repo/play_repo.dart';

int? indextemp;
String? songurl;

class MiniPlayer extends StatelessWidget {
  MiniPlayer({required this.fullSong, required this.index, Key? key})
      : super(key: key);
  final List<Audio> fullSong;

  final int index;

  bool nextDone = true;
  bool preDone = true;
//
  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");

  //

//
  Audio findPlayPath(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (songurl == null || songurl != fullSong[index].path) {
        PlaySong(fullSongs: fullSong, index: index).startPlay();
      }
      indextemp = index;
      songurl = fullSong[index].path;
    });

    var size = MediaQuery.of(context).size;
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return assetAudioPlayer.builderCurrent(
        builder: (BuildContext context, Playing playing) {
      final nowSong = findPlayPath(fullSong, playing.audio.assetAudioPath);
      return GestureDetector(
        onTap: () {
          Play.goToNowPlaying(
            context,
            fullSong,
          );
        },
        onVerticalDragUpdate: (details) {
          if (details.delta.direction < 0) {
            Play.goToNowPlaying(
              context,
              fullSong,
            );
          } else {
            Navigator.pop(context);
          }
        },
        onHorizontalDragUpdate: (details) {},
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            //* background ice container
            SlideInUp(
              // duration: Duration(milliseconds: 400),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: 170,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: lTheme
                            ? Colors.grey.shade400.withOpacity(0.5)
                            : Colors.grey.shade900.withOpacity(0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              left: MediaQuery.of(context).size.height / 8,
                            ),
                            child: MyFont.montBold16(
                              nowSong.metas.title!.toUpperCase(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              left: MediaQuery.of(context).size.height / 8,
                            ),
                            child: MyFont.montSemiBold10grey(
                              nowSong.metas.artist!.toUpperCase() == '<UNKNOWN>'
                                  ? "Unknown Artist"
                                  : nowSong.metas.artist!.toUpperCase(),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: MediaQuery.of(context).size.height / 8,
                              ),
                              child: miniSeekBar(context))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //*white Container----->
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
              // width: size.width * 0.8,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                boxShadow: [
                  MyTheme.myBoxShadow(),
                  MyTheme.myBoxShadow(),
                  MyTheme.myBoxShadow(),
                ],
                color: lTheme ? MyTheme.blueDark : MyTheme.d_light,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 30,
                          onPressed: () async {
                            if (preDone) {
                              preDone = false;
                              await assetAudioPlayer.previous();

                              preDone = true;
                            }
                          },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            color: lTheme ? MyTheme.light : MyTheme.d_base,
                          ),
                        ),
                        SongPlayMiniButton(
                            assetAudioPlayer: assetAudioPlayer, lTheme: lTheme),
                        IconButton(
                          iconSize: 30,
                          onPressed: () async {
                            if (nextDone) {
                              nextDone = false;

                              await assetAudioPlayer.next();
                              nextDone = true;
                            }
                          },
                          icon: Icon(
                            Icons.skip_next_rounded,
                            color: lTheme ? MyTheme.light : MyTheme.d_base,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: lTheme ? MyTheme.light : MyTheme.d_base,
                      ),
                      child: Icon(
                        Icons.speaker,
                        color: lTheme ? MyTheme.blueDark : MyTheme.d_light,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //*Song Image--->

            Positioned(
              left: 40,
              bottom: 55,
              child: MiniPlayerSongImage(nowSong: nowSong),
            ),
          ],
        ),
      );
    });
  }
}

class SongPlayMiniButton extends StatelessWidget {
  const SongPlayMiniButton({
    Key? key,
    required this.assetAudioPlayer,
    required this.lTheme,
  }) : super(key: key);

  final AssetsAudioPlayer assetAudioPlayer;
  final bool lTheme;

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.isPlaying(
      player: assetAudioPlayer,
      builder: (context, isPaying) {
        return IconButton(
          iconSize: 50,
          onPressed: () async {
            await assetAudioPlayer.playOrPause();
          },
          icon: Icon(
            isPaying
                ? Icons.pause_circle_outline
                : Icons.play_circle_filled_rounded,
            color: lTheme ? MyTheme.light : MyTheme.d_base,
          ),
        );
      },
    );
  }
}

// !widgets

class MiniPlayerSongImage extends StatelessWidget {
  const MiniPlayerSongImage({
    Key? key,
    required this.nowSong,
  }) : super(key: key);

  final Audio nowSong;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: MediaQuery.of(context).size.height / 11,
      width: MediaQuery.of(context).size.height / 11,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          MyTheme.myBoxShadow(),
          MyTheme.myBoxShadow(),
          MyTheme.myBoxShadow(),
        ],
      ),
      child: QueryArtworkWidget(
        nullArtworkWidget: Image.asset(
          'assets/images/red_lady.png',
          fit: BoxFit.cover,
        ),
        artworkClipBehavior: Clip.none,
        artworkFit: BoxFit.cover,
        id: int.parse(nowSong.metas.id!),
        type: ArtworkType.AUDIO,
      ),
    );
  }
}
