import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:amuzic/widgets/add_create_edit_playlist.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PopUpMenu extends StatefulWidget {
  PopUpMenu({required this.songId, Key? key}) : super(key: key);
  String songId;

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  final box = Mybox.getinstance();

  List<LocalStorageSongs> dbSongs = [];

  List<Audio> fullSongs = [];

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    dbSongs = Mybox.getDbSongs();
    List? favourites = box!.get("favourites");
    final temp = Mybox.getDbSongWithId(songs: dbSongs, songId: widget.songId);

    return ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, value, child) {
          return PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: lTheme ? MyTheme.blueDark : MyTheme.d_blueDark,
            itemBuilder: ((context) => [
                  favourites!
                          .where((element) =>
                              element.id.toString() == temp.id.toString())
                          .isEmpty
                      ? PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(
                              Icons.favorite_rounded,
                              color: Colors.white,
                            ),
                            title:
                                MyFont.montMedium13White('Add to Favourites'),
                            onTap: () async {
                              Navigator.pop(context);

                              favourites.add(temp);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: MyTheme.red,
                                    content: MyFont.montMedium13White(
                                        '${temp.title}  Added to Favourites')),
                              );
                              await box!.put("favourites", favourites);
                              setState(() {});
                            },
                          ),
                        )
                      : PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                            ),
                            title: MyFont.montMedium13White(
                                'Remove from Favorites'),
                            onTap: () async {
                              Navigator.pop(context);

                              favourites.removeWhere((element) =>
                                  element.id.toString() == temp.id.toString());
                              // favourites.remove(temp);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: MyTheme.red,
                                  content: MyFont.montMedium13White(
                                    temp.title! + " Removed from Favourites",
                                  ),
                                ),
                              );
                              await box!.put("favourites", favourites);

                              setState(() {});
                            },
                          ),
                        ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pop();

                        showDialog(
                            context: context,
                            builder: (context) => AddToPlaylist(
                                  song: temp,
                                ));
                      },
                      leading: const Icon(
                        Icons.playlist_add,
                        color: Colors.white,
                      ),
                      title: MyFont.montMedium13White('Add to Playlist'),
                    ),
                  ),
                ]),
            icon: favourites!
                    .where((element) =>
                        element.id.toString() == temp.id.toString())
                    .isEmpty
                ? Icon(
                    Icons.more_vert,
                    color: lTheme ? MyTheme.blueDark : MyTheme.light,
                  )
                : Icon(
                    Icons.favorite,
                    color: lTheme ? MyTheme.red : MyTheme.d_red,
                  ),
          );
        });
  }
}
