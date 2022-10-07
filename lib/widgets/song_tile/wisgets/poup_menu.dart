import 'package:amuzic/application/favourites_screen_bloc/favourites_screen_bloc.dart';
import 'package:amuzic/application/song_tile_bloc/song_tile_bloc.dart';
import 'package:amuzic/domine/database/database_model.dart';
import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/presentation/screens/playlist_screen/widgets/add_create_edit_playlist.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PopUpMenu extends StatelessWidget {
  PopUpMenu({required this.songId, required this.isEmpty, Key? key})
      : super(key: key);
  final String songId;
  final bool isEmpty;
  final box = Mybox.getinstance();

  List<LocalStorageSongs> dbSongs = [];

  // List<Audio> fullSongs = [];

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;
    dbSongs = Mybox.getDbSongs();
    List? favourites = box!.get("favourites");
    final temp = Mybox.getDbSongWithId(songs: dbSongs, songId: songId);

    return ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, child, _) {
          return PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: lTheme ? MyTheme.blueDark : MyTheme.d_blueDark,
            itemBuilder: ((context) => [
                  favourites!
                          .where((element) => element.id.toString() == songId)
                          .isEmpty
                      // isEmpty
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

                              // favourites.add(temp);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.green,
                                    content: MyFont.montMedium13(
                                        '${temp.title}  Added to Favourites')),
                              );
                              // await box!.put("favourites", favourites);

                              await Mybox.addSongToPlayList(
                                  song: temp, playListName: "favourites");
                              BlocProvider.of<FavouritesScreenBloc>(context)
                                  .add(GetFavSongsEvent());
                              // setState(() {});
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

                              // favourites.removeWhere((element) =>
                              //     element.id.toString() == temp.id.toString());
                              // favourites.remove(temp);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: MyTheme.red,
                                  content: MyFont.montMedium13White(
                                    temp.title! + " Removed from Favourites",
                                  ),
                                ),
                              );
                              // await box!.put("favourites", favourites);

                              await Mybox.deleteSongFoRPlayList(
                                  song: temp, playListName: "favourites");
                              BlocProvider.of<FavouritesScreenBloc>(context)
                                  .add(GetFavSongsEvent());

                              // setState(() {});
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
            // icon: isEmpty
            icon: favourites!
                    .where((element) => element.id.toString() == songId)
                    .isEmpty
                // icon: state.isEmpty
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
