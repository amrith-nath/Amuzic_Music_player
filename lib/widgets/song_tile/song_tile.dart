import 'dart:developer';

import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/widgets/mini_player/mini_player.dart';
import 'package:amuzic/widgets/song_tile/wisgets/poup_menu.dart';
import 'package:amuzic/widgets/song_tile/wisgets/visualizer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatefulWidget {
  SongTile(
    this.image, {
    required this.songs,
    required this.index,
    Key? key,
  }) : super(key: key);

  int index;
  int image;
  List<Audio> songs;

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  // final tileBox = Mybox.getinstance();
  // List<LocalStorageSongs> dbSongs = [];

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Scaffold.of(context).showBottomSheet((context) => MiniPlayer(
        //       fullSong: songs,
        //       index: index,
        //     ));
        showBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => MiniPlayer(
            fullSong: widget.songs,
            index: widget.index,
          ),
        );

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (ctx) => PlaysongScreen(
        //       widget.image,
        //       widget.index,
        //       true,
        //       widget.songs,
        //       widget.audioPlayer,
        //     ),
        //   ),
        // );
      },
      onDoubleTap: () {
        // setState(() {});
      },
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: lTheme ? Colors.white : MyTheme.d_blueDark,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [MyFont.myBoxShadow()],
            ),
            width: width - 20,
            height: MediaQuery.of(context).size.height / 8,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Visualizer(song: widget.songs[widget.index]),
              ],
            ),
            // child: Visualizer(song: widget.songs[widget.index]),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //     image: AssetImage(widget.image), fit: BoxFit.cover),
                          // color: Colors.grey,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(50),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(50),
                          ),
                          boxShadow: [MyFont.myBoxShadow()],
                        ),
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.height / 8,
                        child: QueryArtworkWidget(
                          nullArtworkWidget: Image.asset(
                            'assets/images/red_lady.png',
                            fit: BoxFit.cover,
                          ),
                          artworkClipBehavior: Clip.none,
                          artworkFit: BoxFit.cover,
                          id: widget.image,
                          type: ArtworkType.AUDIO,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: MyFont.montBold16(
                                widget.songs[widget.index].metas.title!),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: MyFont.montMedium13(widget
                                          .songs[widget.index].metas.artist ==
                                      '<unknown>'
                                  ? 'no artist'
                                  : widget.songs[widget.index].metas.artist!)),

                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: MyFont.montMedium13('')),
                          //todo add duration field & update Hive field
                        ],
                      ),
                      ZoomIn(
                        key: const Key('dots'),
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lTheme ? MyTheme.light : MyTheme.d_base,
                          ),
                          // child: const Icon(
                          //   Icons.more_vert_outlined,
                          //   color: Color.fromARGB(255, 17, 17, 17),
                          // ),

                          child: PopUpMenu(
                            songId: widget.songs[widget.index].metas.id!,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
