import 'dart:ui';

import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:amuzic/widgets/seek_bar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/play_song.dart';

class MiniPlayer extends StatefulWidget {
  MiniPlayer({required this.fullSong, required this.index, Key? key})
      : super(key: key);
  List<Audio> fullSong;

  int index;

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

int? indextemp;

class _MiniPlayerState extends State<MiniPlayer> {
//
  final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");

  //

//
  Audio findPlayPath(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    if (indextemp == null || indextemp != widget.index) {
      PlaySong(fullSongs: widget.fullSong, index: widget.index).startPlay();
    }
    indextemp = widget.index;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return assetAudioPlayer.builderCurrent(
        builder: (BuildContext context, Playing playing) {
      final nowSong =
          findPlayPath(widget.fullSong, playing.audio.assetAudioPath);
      return GestureDetector(
        // onTap: () {
        //   MyFont.myClick();
        //   Play.goToNowPlaying(context, widget.fullSong);
        //   // Navigator.of(context)
        //   //     .push(MaterialPageRoute(builder: (ctx) => PlayScreen()));
        // },
        onVerticalDragUpdate: (details) {
          if (details.delta.direction < 0) {
            Play.goToNowPlaying(
              context,
              widget.fullSong,
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
                        color: Colors.grey.shade400.withOpacity(0.5),
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
                              nowSong.metas.title!.toUpperCase(),
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
                color: MyTheme.blueDark,
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
                            await assetAudioPlayer.previous();
                          },
                          icon: Icon(
                            Icons.skip_previous_rounded,
                            color: MyTheme.light,
                          ),
                        ),
                        PlayerBuilder.isPlaying(
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
                                color: MyTheme.light,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          iconSize: 30,
                          onPressed: () async {
                            await assetAudioPlayer.next();
                          },
                          icon: Icon(
                            Icons.skip_next_rounded,
                            color: MyTheme.light,
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
                        color: MyTheme.light,
                      ),
                      child: Icon(
                        Icons.speaker,
                        color: MyTheme.blueDark,
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
              child: Container(
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
              ),
            ),
            // Positioned(
            //     left: MediaQuery.of(context).size.width / 2.9,
            //     bottom: MediaQuery.of(context).size.height / 8,
            //     child: ),
          ],
        ),
      );
    });
  }
}