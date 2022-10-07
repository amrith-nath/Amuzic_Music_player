import 'dart:developer';

import 'package:amuzic/application/playlist_expanded_bloc/playlist_expanded_bloc.dart';
import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlayListExpanded extends StatelessWidget {
  PlayListExpanded({required this.playlistName, Key? key}) : super(key: key);
  final String playlistName;

  final box = Mybox.getinstance();

  List<Audio> playListtemp = [];

  bool isFABSwitched = true;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<PlaylistExpandedBloc>(context)
          .add(OnGetPlayListSongs(playListName: playlistName));
    });

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
          child: BlocBuilder<PlaylistExpandedBloc, PlaylistExpandedState>(
              builder: (context, state) {
            playListtemp = [];
            final playlistSongs = state.playListSongs;

            for (var element in playlistSongs) {
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
                              if (details.delta.direction > 0) {}
                            }),
                            child: SongTile(
                              songs: playListtemp,
                              index: index,
                              playlistName: playlistName,
                            ),
                          ));
                    },
                  )
                : Center(
                    child: MyFont.montMedium13("No Songs found , Add some"));
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
