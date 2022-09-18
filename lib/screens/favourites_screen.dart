import 'dart:developer';

import 'package:amuzic/widgets/buttons.dart';
import 'package:amuzic/widgets/song_tile.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../widgets/add_song_bar.dart';

class favourites extends StatelessWidget {
  const favourites({Key? key}) : super(key: key);

  final String playlistName = "favourites";

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    // List<LocalStorageSongs>? dbSongs = [];

    final box = Mybox.getinstance();
    bool isFABSwitched = true;

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
              scrolledUnderElevation: 3,
              leadingWidth: 100,
              elevation: 0,
              stretch: true,
              backgroundColor: lTheme ? MyTheme.light : MyTheme.d_blueDark,
              leading: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  MyBackButton(
                    context: context,
                  ),
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
                      MyFont.montBold24Red('FAV'),
                      MyFont.montBold24('OURITES', context),
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
                final favSongs = box.get(playlistName);
                List<Audio> favSongsTemp = [];
                for (var element in favSongs!) {
                  favSongsTemp.add(Audio.file(element.uri,
                      metas: Metas(
                        title: element.title,
                        id: element.id.toString(),
                        artist: element.artist,
                      )));
                }
                return favSongs.isNotEmpty
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: favSongs.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: SongTile(
                                int.parse(favSongsTemp[index].metas.id!),
                                songs: favSongsTemp,
                                index: index,
                              ));
                        },
                      )
                    : Center(
                        child: MyFont.montMedium13(
                            "No Favourites found , add some"),
                      );
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
                    Icons.expand_more_sharp,
                    size: 40,
                    color: MyTheme.light,
                  ),
          );
        });
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
