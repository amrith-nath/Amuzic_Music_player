import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/screens/playlist_expanded.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:amuzic/widgets/add_create_edit_playlist.dart';
import 'package:amuzic/widgets/buttons.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final box = Mybox.getinstance();
  List playlists = [];
  String? playlistName = '';
  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        automaticallyImplyLeading: false,
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
                      MyFont.montBold24Red('PLAY'),
                      MyFont.montBold24('LISTS', context),
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: SlideInRight(
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 2));
            },
            child: ValueListenableBuilder(
                valueListenable: box!.listenable(),
                builder: (context, boxes, _) {
                  playlists = box!.keys.toList();
                  return playlists.length != 3
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: playlists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child:
                                    playlists[index] != "musics" &&
                                            playlists[index] != "favourites" &&
                                            playlists[index] != "recent"
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: PlayListExpanded(
                                                          playlistName:
                                                              playlists[
                                                                  index])));

                                              MyFont.myClick();
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 30),
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: lTheme
                                                    ? Colors.white
                                                    : MyTheme.d_blueDark,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  MyTheme.myBoxShadow(),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        color: MyTheme.red,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  50),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  50),
                                                        ),
                                                        boxShadow: [
                                                          MyTheme.myBoxShadow()
                                                        ]),
                                                    child: Icon(
                                                      Icons
                                                          .playlist_play_rounded,
                                                      size: 40,
                                                      color: lTheme
                                                          ? MyTheme.blueDark
                                                          : MyTheme.d_base,
                                                    ),
                                                  ),
                                                  MyFont.montSemiBold16(
                                                    playlists[index]
                                                        .toString()
                                                        .toUpperCase(),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        backgroundColor: lTheme
                                                                            ? MyTheme.blueDark
                                                                            : MyTheme.d_blueDark,
                                                                        content:
                                                                            MyFont.montMedium13White("Are you sure you want to delete?"),
                                                                        actions: [
                                                                          TextButton
                                                                              .icon(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.close,
                                                                              color: Colors.red,
                                                                            ),
                                                                            label:
                                                                                MyFont.montMedium13White("No"),
                                                                          ),
                                                                          TextButton
                                                                              .icon(
                                                                            onPressed:
                                                                                () {
                                                                              box!.delete(playlists[index]);
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(backgroundColor: MyTheme.d_red, content: MyFont.montMedium13('${playlists[index].toString().toUpperCase()}  Deleted')),
                                                                              );
                                                                              setState(() {
                                                                                playlists = box!.keys.toList();
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.done,
                                                                              color: Colors.green,
                                                                            ),
                                                                            label:
                                                                                MyFont.montMedium13White("Yes"),
                                                                          ),
                                                                        ],
                                                                      ));
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                          color: lTheme
                                                              ? Colors.black
                                                              : MyTheme.d_light,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  PlayListEdit(
                                                                      playListName:
                                                                          playlists[
                                                                              index]));
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .edit_note_rounded,
                                                          color: lTheme
                                                              ? Colors.black
                                                              : MyTheme.d_light,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : null);
                          },
                        )
                      : Center(child: MyFont.montMedium13("No playlist found"));
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'faB',
        backgroundColor: lTheme ? MyTheme.blueDark : MyTheme.d_red,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => CreatePlaylistDlg());
        },
        child: Icon(
          Icons.add,
          size: 40,
          color: MyTheme.light,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
