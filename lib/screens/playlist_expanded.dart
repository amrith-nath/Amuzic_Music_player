import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:amuzic/widgets/buttons.dart';
import 'package:amuzic/widgets/song_tile.dart';
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
                      MyFont.montBold24(playlistName, context),
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
                final playlistSongs = box!.get(playlistName);

                for (var element in playlistSongs!) {
                  playListtemp.add(Audio.file(element.uri,
                      metas: Metas(
                        title: element.title,
                        id: element.id.toString(),
                        artist: element.artist,
                      )));
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: playlistSongs.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                                                MyFont.montMedium13White("No"),
                                          ),
                                          TextButton.icon(
                                            onPressed: () {
                                              playlistSongs.removeAt(index);
                                              box!.put(
                                                  playlistName, playlistSongs);
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            ),
                                            label:
                                                MyFont.montMedium13White("Yes"),
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
                );
              }),
        ),
      ),
    );
  }
}
