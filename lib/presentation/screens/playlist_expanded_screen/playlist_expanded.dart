import 'dart:developer';

import 'package:amuzic/domine/database/db_functions.dart';
import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/widgets/add_song_bar/add_song_bar.dart';
import 'package:amuzic/widgets/butttons/buttons.dart';
import 'package:amuzic/widgets/mini_player/mini_player.dart';
import 'package:amuzic/widgets/song_tile/song_tile.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlayListExpanded extends StatelessWidget {
  PlayListExpanded({required this.playlistName, Key? key}) : super(key: key);
  final String playlistName;

  final box = Mybox.getinstance();

  List<Audio> playListtemp = [];

  bool isFABSwitched = true;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 10,
        elevation: 0,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrlled) {
          return <Widget>[
            SliverAppBar(
              collapsedHeight: 65,
              scrolledUnderElevation: 5,
              leadingWidth: 100,
              elevation: 0,
              stretch: true,
              backgroundColor: lTheme ? MyTheme.light : MyTheme.d_blueDark,
              leading: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  MyBackButton(context: context),
                ],
              ),
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                title: SlideInRight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyFont.montBold24(playlistName.toUpperCase(), context),
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: SlideInRight(
          child: ValueListenableBuilder(
              valueListenable: box!.listenable(),
              builder: (context, value, child) {
                playListtemp = [];
                final playlistSongs = box!.get(playlistName);

                for (var element in playlistSongs!) {
                  playListtemp.add(Audio.file(element.uri,
                      metas: Metas(
                        title: element.title,
                        id: element.id.toString(),
                        artist: element.artist,
                      )));
                }

                log(playlistSongs.length.toString());
                log(playListtemp.length.toString());

                return playlistSongs.isNotEmpty
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: playlistSongs.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: GestureDetector(
                                onHorizontalDragUpdate: ((details) {
                                  if (details.delta.direction > 0) {
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              backgroundColor: MyTheme.blueDark,
                                              content: MyFont.montMedium13White(
                                                  "Are you sure you want to delete?"),
                                              actions: [
                                                TextButton.icon(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                  label:
                                                      MyFont.montMedium13White(
                                                          "No"),
                                                ),
                                                TextButton.icon(
                                                  onPressed: () async {
                                                    Navigator.pop(context);

                                                    playlistSongs.removeWhere(
                                                        (item) =>
                                                            item.id
                                                                .toString() ==
                                                            playlistSongs[index]
                                                                .id
                                                                .toString());
                                                    await box!.put(playlistName,
                                                        playlistSongs);
                                                  },
                                                  icon: const Icon(
                                                    Icons.done,
                                                    color: Colors.green,
                                                  ),
                                                  label:
                                                      MyFont.montMedium13White(
                                                          "Yes"),
                                                ),
                                              ],
                                            )));
                                  }
                                }),
                                child: SongTile(
                                  playlistSongs[index].id!,
                                  songs: playListtemp,
                                  index: index,
                                ),
                              ));
                        },
                      )
                    : Center(
                        child:
                            MyFont.montMedium13("No Songs found , Add some"));
              }),
        ),
      ),
      floatingActionButton: Builder(builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return FloatingActionButton(
            heroTag: 'faB',
            elevation: 20,
            enableFeedback: true,
            backgroundColor: lTheme ? MyTheme.blueDark : MyTheme.d_red,
            onPressed: () {
              if (isFABSwitched) {
                showBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => AddSongBar(
                    playListName: playlistName,
                  ),
                );
                isFABSwitched = false;
              } else {
                Navigator.of(context).pop();
                isFABSwitched = true;
              }
              // AddSongBar(
              //   mycontext: context,
              // ).showOrHide();
              // log("message");
              setState(() {});
            },
            child: isFABSwitched
                ? Icon(
                    Icons.add,
                    size: 40,
                    color: MyTheme.light,
                  )
                : Icon(
                    Icons.expand_more_rounded,
                    size: 30,
                    color: MyTheme.light,
                  ),
          );
        });
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
