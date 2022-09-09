import 'dart:developer';

import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:amuzic/widgets/song_tile.dart';
import 'package:amuzic/widgets/buttons.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({required this.userName, required this.allSongs, Key? key})
      : super(key: key);
  final String userName;
  final List<Audio> allSongs;

  @override
  State<MyHome> createState() => _MyHomeState();
}

TextEditingController myController = TextEditingController();

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //* List? dbSongs = [];
  //* List<dynamic> favorites = [];
  // *List<dynamic> likedSongs = [];
  //*-----
  final box = Mybox.getinstance();
  final AssetsAudioPlayer myPlayer = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;
    log(lTheme.toString());

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrlled) {
        return <Widget>[
          Builder(builder: (context) {
            return SliverAppBar(
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
                  DrawerButton(
                    context: context,
                  )
                ],
              ),
              actions: [
                SearchButton(
                  context: context,
                ),
                const SizedBox(
                  width: 20,
                )
              ],
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyFont.montBold24Red('H'),
                    MyFont.montBold24('OME', context),
                  ],
                ),
              ),
            );
          })
        ];
      },
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2));
        },
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.allSongs.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 20,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SongTile(
                  int.parse(widget.allSongs[index].metas.id!),
                  songs: widget.allSongs,
                  index: index,
                ));
          },
        ),
      ),
    );
  }
}
