import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:xen_popup_card/xen_card.dart';

class AddToPlaylist extends StatelessWidget {
  AddToPlaylist({required this.song, Key? key}) : super(key: key);
  LocalStorageSongs song;
  List playlistsNames = [];
  List<dynamic>? playlistSongs = [];
  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    final box = Mybox.getinstance();
    playlistsNames = box!.keys.toList();
    return SlideInUp(
      duration: const Duration(milliseconds: 300),
      child: XenPopupCard(
        cardBgColor: lTheme ? MyTheme.light : MyTheme.d_light,
        appBar: XenCardAppBar(
            color: lTheme ? MyTheme.blueDark : MyTheme.d_blueDark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyFont.montSemiBold13White("Add To Playlist"),
              ],
            )),
        gutter: XenCardGutter(
          child: Container(
            color: lTheme ? MyTheme.light : MyTheme.d_blueDark,
            height: 50,
            width: double.infinity,
            child: Center(
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) => CreatePlaylistDlg());
                    },
                    icon: Icon(
                      Icons.playlist_add,
                      size: 30,
                      color: MyTheme.red,
                    ),
                    label: MyFont.montBold16("Create New Playlist"))),
          ),
        ),

        //todo try spread operated list generation

        // body: ListView(
        //   children: [
        //     ...playlistsNames
        //         .map(
        //           (playlistname) =>
        //               playlistname != "musics" && playlistname != "favourites"
        //                   ? ListTile(
        //                       title: playlistname,
        //                     )
        //                   : const SizedBox(),
        //         )
        //         .toList()
        //   ],
        // ),

        body: ListView.builder(
          itemCount: playlistsNames.length,
          itemBuilder: (BuildContext context, int index) {
            return playlistsNames[index] != "musics" &&
                    playlistsNames[index] != "favourites"
                ? Container(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListTile(
                      onTap: () async {
                        playlistSongs = box.get(playlistsNames[index]);
                        List existingSongs = playlistSongs!
                            .where((element) =>
                                element.id.toString() == song.id.toString())
                            .toList();
                        if (existingSongs.isEmpty) {
                          final songs =
                              box.get("musics") as List<LocalStorageSongs>;
                          final temp = songs.firstWhere((element) =>
                              element.id.toString() == song.id.toString());
                          playlistSongs!.add(temp);
                          await box.put(playlistsNames[index], playlistSongs!);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              '${song.title!}  Added to Playlist',
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${song.title} is already in Playlist.',
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                          );
                        }
                      },
                      leading: const Icon(
                        Icons.playlist_play_rounded,
                        color: Colors.white,
                      ),
                      tileColor: lTheme ? MyTheme.blueDark : MyTheme.d_blueDark,
                      title: MyFont.montBold16White(
                        playlistsNames[index],
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}

//* create PlayList-------------->
class CreatePlaylistDlg extends StatelessWidget {
  CreatePlaylistDlg({Key? key}) : super(key: key);
  //*------------->
  //todo add option for adding to fav<3;

  String? playlistName;
  List<LocalStorageSongs> playlists = [];
  final formkey = GlobalKey<FormState>();
  //*------------>
  @override
  Widget build(BuildContext context) {
    final box = Mybox.getinstance();
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return SlideInUp(
      duration: const Duration(milliseconds: 300),
      child: AlertDialog(
        backgroundColor: lTheme ? MyTheme.light : MyTheme.d_blueDark,
        title: Center(
          child: Row(children: [
            MyFont.montBold16("Enter Name for The "),
            MyFont.montBold16Red("Playlist"),
          ]),
        ),
        content: Form(
          key: formkey,
          child: TextFormField(
            validator: ((value) {
              List keys = box!.keys.toList();
              if (value == null || value.isEmpty || value.trim() == '') {
                return 'A Name Is Requiered';
              }
              if (keys.where((element) => element == value.trim()).isNotEmpty) {
                return "this name already exists";
              }
              return null;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: lTheme
                  ? const Color.fromRGBO(217, 217, 217, 1)
                  : MyTheme.d_light,
            ),
            style: const TextStyle(
              decoration: TextDecoration.none,
              fontSize: 22,
              fontFamily: 'Poppins',
            ),
            onChanged: (value) {
              playlistName = value.trim();
            },
          ),
        ),
        actions: [
          Center(
            child: TextButton.icon(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    box!.put(playlistName, playlists);
                    Navigator.pop(context);
                  }
                },
                icon: Icon(
                  Icons.add_circle_sharp,
                  color: MyTheme.red,
                  size: 30,
                ),
                label: MyFont.montSemiBold16("Add Playlist")),
          )
        ],
      ),
    );
  }
}

class PlayListEdit extends StatelessWidget {
  PlayListEdit({required this.playListName, this.setState, Key? key})
      : super(key: key);
  String playListName;
  Function? setState;

  final box = Mybox.getinstance();

  String? newName;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    return SlideInUp(
      duration: const Duration(milliseconds: 300),
      child: AlertDialog(
        title: Center(
          child: Row(children: [
            MyFont.montBold16("Enter Name for The "),
            MyFont.montBold16Red("Playlist"),
          ]),
        ),
        content: Form(
          key: formkey,
          child: TextFormField(
            initialValue: playListName,
            validator: ((value) {
              List keys = box!.keys.toList();
              if (value == null || value.isEmpty || value.trim() == '') {
                return 'A Name Is Requiered';
              }
              if (keys.where((element) => element == value.trim()).isNotEmpty) {
                return "this name already exists";
              }
              return null;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: lTheme
                  ? const Color.fromRGBO(217, 217, 217, 1)
                  : MyTheme.d_blueDark,
            ),
            style: const TextStyle(
              decoration: TextDecoration.none,
              fontSize: 22,
              fontFamily: 'Poppins',
            ),
            onChanged: (value) {
              newName = value.trim();
            },
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
              label: MyFont.montSemiBold16("CANCEL")),
          TextButton.icon(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  List? playList = box!.get(playListName);
                  box!.put(newName, playList!);
                  box!.delete(playListName);
                  Navigator.pop(context);
                }
                setState;
              },
              icon: const Icon(
                Icons.done,
                color: Colors.green,
                size: 30,
              ),
              label: MyFont.montSemiBold16("OK")),
        ],
      ),
    );
  }
}
