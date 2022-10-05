import 'dart:developer';

import 'package:amuzic/domine/database/db_functions.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/widgets/butttons/buttons.dart';
import 'package:amuzic/widgets/song_tile/song_tile.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/fonts/fonts.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Audio> recentSongsTemp = [];
    final box = Mybox.getinstance();

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
                      MyFont.montBold24Red('RECENT'),
                      MyFont.montBold24('SONGS', context),
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
                final recentSongs = box.get("recent");
                log("${recentSongs!.length}");

                for (var element in recentSongs) {
                  recentSongsTemp.add(Audio.file(element.uri,
                      metas: Metas(
                        title: element.title,
                        id: element.id.toString(),
                        artist: element.artist,
                      )));
                }

                return recentSongs.isNotEmpty
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: recentSongs.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: SongTile(
                                recentSongs[index].id!,
                                songs: recentSongsTemp,
                                index: index,
                              ));
                        },
                      )
                    : Center(
                        child: MyFont.montMedium13(
                            "No Recent Songs found , play some"),
                      );
              }),
        ),
      ),
    );
  }
}
