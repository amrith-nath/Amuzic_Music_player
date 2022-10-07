import 'package:amuzic/application/song_tile_bloc/song_tile_bloc.dart';
import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/widgets/mini_player/mini_player.dart';
import 'package:amuzic/widgets/song_tile/wisgets/poup_menu.dart';
import 'package:amuzic/widgets/song_tile/wisgets/visualizer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    required this.songs,
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  final List<Audio> songs;

  // final tileBox = Mybox.getinstance();
  // List<LocalStorageSongs> dbSongs = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SongTileBloc>(context)
          .add(GetFavInfoEvent(songId: songs[index].metas.id!));
    });

    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        showBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => MiniPlayer(
            fullSong: songs,
            index: index,
          ),
        );
      },
      onDoubleTap: () {},
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
                Visualizer(song: songs[index]),
              ],
            ),
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
                      SongTileImageContainer(
                          image: int.parse(songs[index].metas.id!)),
                      SongTileTextWidget(songs: songs, index: index),
                      SongTileMenuWidget(
                          lTheme: lTheme,
                          songs: songs,
                          index: index,
                          isEmpty: true)
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class SongTileMenuWidget extends StatelessWidget {
  const SongTileMenuWidget(
      {Key? key,
      required this.lTheme,
      required this.songs,
      required this.index,
      required this.isEmpty})
      : super(key: key);

  final bool lTheme;
  final List<Audio> songs;
  final int index;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
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
        child: PopUpMenu(songId: songs[index].metas.id!, isEmpty: isEmpty),
      ),
    );
  }
}

class SongTileTextWidget extends StatelessWidget {
  const SongTileTextWidget({
    Key? key,
    required this.songs,
    required this.index,
  }) : super(key: key);

  final List<Audio> songs;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: MyFont.montBold16(songs[index].metas.title!),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: MyFont.montMedium13(songs[index].metas.artist == '<unknown>'
                ? 'no artist'
                : songs[index].metas.artist!)),

        SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: MyFont.montMedium13('')),
        //todo add duration field & update Hive field
      ],
    );
  }
}

class SongTileImageContainer extends StatelessWidget {
  const SongTileImageContainer({
    Key? key,
    required this.image,
  }) : super(key: key);

  final int image;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
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
        id: image,
        type: ArtworkType.AUDIO,
      ),
    );
  }
}
