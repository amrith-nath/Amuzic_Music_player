import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/functions/marquee_class.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:amuzic/widgets/add_create_edit_playlist.dart';
import 'package:amuzic/widgets/seek_bar.dart';
import 'package:amuzic/widgets/top_container.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({required this.fullsong, Key? key}) : super(key: key);
  final List<Audio> fullsong;

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

final AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer.withId("0");
Audio findPlayPath(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class _PlayScreenState extends State<PlayScreen> {
  final box = Mybox.getinstance();
  bool isLooping = false;
  bool isShuffle = false;
  bool nextDone = true;
  bool preDone = true;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    var size = MediaQuery.of(context).size;
    return assetAudioPlayer.builderCurrent(
        builder: (BuildContext context, Playing playing) {
      final nowPlaying =
          findPlayPath(widget.fullsong, playing.audio.assetAudioPath);

      return Builder(builder: (context) {
        return GestureDetector(
          onVerticalDragUpdate: ((details) {
            if (details.delta.direction > 0) {
              Navigator.of(context).pop();
            }
          }),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              toolbarHeight: 5,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SlideInUp(
                          duration: const Duration(milliseconds: 300),
                          child: TopContainerPlay(size.width, size.height,
                              int.parse(nowPlaying.metas.id!)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          width: size.width * 0.6,
                          child: MarqueeWidget(
                              direction: Axis.horizontal,
                              child: MyFont.montBold36(
                                  nowPlaying.metas.title!.toUpperCase())),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: MarqueeWidget(
                              direction: Axis.horizontal,
                              child: MyFont.montMedium13(
                                  nowPlaying.metas.artist == "<unknown>"
                                      ? "UNKNOWN ARTIST"
                                      : nowPlaying.metas.artist!
                                          .toUpperCase())),
                        ),
                      ],
                    ),
                    ZoomIn(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * 0.1, 50, size.width * 0.1, 20),
                            child: mainSeekBar(context),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SlideInRight(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return isLooping
                                      ? IconButton(
                                          iconSize: 30,
                                          onPressed: () {
                                            setState(() {
                                              isLooping = false;
                                              assetAudioPlayer.setLoopMode(
                                                  LoopMode.playlist);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.repeat_one,
                                            color: lTheme
                                                ? Colors.grey.shade700
                                                : MyTheme.d_blueDark,
                                          ),
                                        )
                                      : IconButton(
                                          iconSize: 30,
                                          onPressed: () {
                                            setState(() {
                                              isLooping = true;
                                              assetAudioPlayer
                                                  .setLoopMode(LoopMode.single);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.repeat,
                                            color: lTheme
                                                ? Colors.grey.shade700
                                                : MyTheme.d_blueDark,
                                          ),
                                        );
                                },
                              ),
                            ),
                            // const SizedBox(
                            //   width: 20,
                            // ),
                            SlideInLeft(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return isShuffle
                                      ? IconButton(
                                          iconSize: 30,
                                          onPressed: () {
                                            setState(() {
                                              isShuffle = false;
                                              assetAudioPlayer.setLoopMode(
                                                  LoopMode.playlist);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.cached,
                                            color: lTheme
                                                ? Colors.grey.shade700
                                                : MyTheme.d_blueDark,
                                          ),
                                        )
                                      : IconButton(
                                          iconSize: 30,
                                          onPressed: () {
                                            setState(() {
                                              isShuffle = true;
                                              assetAudioPlayer.toggleShuffle();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.shuffle,
                                            color: lTheme
                                                ? Colors.grey.shade700
                                                : MyTheme.d_blueDark,
                                          ),
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SlideInRight(
                              child: IconButton(
                                iconSize: 30,
                                onPressed: () async {
                                  await assetAudioPlayer
                                      .seekBy(const Duration(seconds: -10));
                                },
                                icon: Icon(
                                  Icons.rotate_left_outlined,
                                  color: lTheme
                                      ? MyTheme.blueDark
                                      : MyTheme.d_blueDark,
                                ),
                              ),
                            ),
                            SlideInRight(
                              child: IconButton(
                                iconSize: 40,
                                onPressed: () async {
                                  if (preDone) {
                                    preDone = false;
                                    await assetAudioPlayer.previous();
                                    preDone = true;
                                  }
                                },
                                icon: Icon(
                                  Icons.skip_previous_rounded,
                                  color: lTheme
                                      ? MyTheme.blueDark
                                      : MyTheme.d_blueDark,
                                ),
                              ),
                            ),
                            PlayerBuilder.isPlaying(
                              player: assetAudioPlayer,
                              builder: (context, isPaying) {
                                return IconButton(
                                  iconSize: 80,
                                  onPressed: () async {
                                    await assetAudioPlayer.playOrPause();
                                  },
                                  icon: Icon(
                                    isPaying
                                        ? Icons.pause_circle_outline
                                        : Icons.play_circle_filled_rounded,
                                    color: lTheme
                                        ? MyTheme.blueDark
                                        : MyTheme.d_blueDark,
                                  ),
                                );
                              },
                            ),
                            SlideInLeft(
                              child: IconButton(
                                iconSize: 40,
                                onPressed: () async {
                                  if (nextDone) {
                                    nextDone = false;
                                    await assetAudioPlayer.next();
                                    nextDone = true;
                                  }
                                },
                                icon: Icon(
                                  Icons.skip_next_rounded,
                                  color: lTheme
                                      ? MyTheme.blueDark
                                      : MyTheme.d_blueDark,
                                ),
                              ),
                            ),
                            SlideInLeft(
                              child: IconButton(
                                iconSize: 30,
                                onPressed: () async {
                                  await assetAudioPlayer
                                      .seekBy(const Duration(seconds: 10));
                                },
                                icon: Icon(
                                  Icons.rotate_right_outlined,
                                  color: lTheme
                                      ? MyTheme.blueDark
                                      : MyTheme.d_blueDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SlideInUp(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: TextButton.icon(
                          onPressed: () {
                            //*------------wooooffff-------->
                            var dbsongs =
                                Mybox.getDbSongs() as List<LocalStorageSongs>;
                            LocalStorageSongs temp = dbsongs.firstWhere(
                                (element) =>
                                    element.id.toString() ==
                                    nowPlaying.metas.id);
                            showDialog(
                                context: context,
                                builder: (context) => AddToPlaylist(
                                      song: temp,
                                    ));
                            //*------------wooooffff-------->
                          },
                          icon: const Icon(Icons.playlist_add),
                          label: MyFont.montSemiBold10('Add to Playlist'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
