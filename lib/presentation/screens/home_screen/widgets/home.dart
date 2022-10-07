import 'dart:developer';

import 'package:amuzic/application/home_screen_bloc/home_screen_bloc.dart';
import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/widgets/song_tile/song_tile.dart';
import 'package:amuzic/widgets/butttons/buttons.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHome extends StatelessWidget {
  const MyHome({required this.userName, Key? key}) : super(key: key);
  final String userName;

  //*-----
  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

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
      body: const HomeListWidget(),
    );
  }
}

class HomeListWidget extends StatelessWidget {
  const HomeListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        BlocProvider.of<HomeScreenBloc>(context).add(GetSongEvent());
      },
    );

    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 2));
      },
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          return state.allSongs.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.allSongs.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SongTile(
                          songs: state.allSongs,
                          index: index,
                        ));
                  },
                )
              : const Center(
                  child: Text(
                      "No Songs Found , Try Add Some or chechk with the storage permissions"));
        },
      ),
    );
  }
}
