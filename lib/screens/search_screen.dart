import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:page_transition/page_transition.dart';
import '../database/database_model.dart';
import '../database/db_functions.dart';
import '../fonts/fonts.dart';
import '../screens/playlist_expanded.dart';
import '../theme/app_theme.dart';
import '../widgets/song_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

String currenttext = '';

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController =
      TextEditingController(text: currenttext);
  final searchBox = Mybox.getinstance();
  List playLists = [];
  List<LocalStorageSongs> songs = [];
  List<Audio> audioSongs = [];
  int flag = 0;
  int flagSong = 0;

  @override
  void initState() {
    playLists = searchBox!.keys.toList();
    songs = Mybox.getDbSongs();
    audioSongs = Mybox.convertToAudio(allSongs: songs);
    flag = findPlaylistName(playList: playLists, currentText: currenttext);
    flagSong = findSongName(playList: audioSongs, currentText: currenttext);

    // implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;

    var playListDecoration = BoxDecoration(
      color: lTheme ? Colors.white : MyTheme.d_base,
      shape: BoxShape.circle,
      border:
          Border.all(style: BorderStyle.solid, color: MyTheme.red, width: 2),
      boxShadow: [
        MyTheme.myBoxShadow(),
      ],
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 20,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyFont.montBold24Red('S'),
                  MyFont.montBold24('EARCH', context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideInLeft(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: size.width - 120,
                      child: TextFormField(
                        controller: _textController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: lTheme
                              ? const Color.fromRGBO(217, 217, 217, 1)
                              : MyTheme.d_blueDark,
                        ),
                        onChanged: (value) {
                          setState(() {
                            currenttext = value;
                            flag = findPlaylistName(
                                playList: playLists, currentText: currenttext);
                            flagSong = findSongName(
                                playList: audioSongs, currentText: currenttext);
                          });
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      MyFont.myClick();
                      Navigator.pop(context);
                    },
                    child: ZoomIn(
                      duration: const Duration(milliseconds: 300),

                      // duration: Duration(milliseconds: 500),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lTheme ? MyTheme.blueDark : MyTheme.d_base,
                        ),
                        width: 60,
                        height: 60,
                        child: Icon(
                          Icons.close_rounded,
                          color: lTheme ? MyTheme.light : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            playLists.length > 2 && flag != 0
                ? MyFont.montBold18("PlayLists")
                : MyFont.montMedium13("No PlayLists found"),
            Divider(
              color: lTheme ? MyTheme.blueDark : MyTheme.light,
            ),
            SlideInRight(
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                height: 120,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...playLists.map(
                      (element) => element
                                  .toString()
                                  .toLowerCase()
                                  .contains(currenttext.toLowerCase()) &&
                              element.toString() != "musics" &&
                              element.toString() != "favourites"
                          ? Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        alignment: Alignment.bottomCenter,
                                        child: PlayListExpanded(
                                          playlistName: element.toString(),
                                        ),
                                      ),
                                    );

                                    MyFont.myClick();
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 100,
                                      width: 100,
                                      decoration: playListDecoration,
                                      child: Center(
                                        child: MyFont.montSemiBold13(
                                          element.toString().toUpperCase(),
                                        ),
                                      )),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            songs.isNotEmpty && flagSong != 0
                ? MyFont.montBold18("Songs")
                : MyFont.montMedium13("No Songs found"),
            Divider(
              color: lTheme ? MyTheme.blueDark : MyTheme.light,
            ),
            Expanded(
                child: currenttext.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            ...audioSongs.map((song) {
                              // log(index.toString());
                              return song.metas.title
                                      .toString()
                                      .toLowerCase()
                                      .contains(currenttext)
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: SongTile(int.parse(song.metas.id!),
                                          songs: audioSongs,
                                          index: int.parse(song.metas.album!)),
                                    )
                                  : Container();
                            }).toList(),
                          ],
                        ),
                      )
                    : MyFont.montRegular10(
                        "Search to find Playlist and Songs ")),
          ],
        ));
  }

//*functions------>

  int findPlaylistName({required List playList, required String currentText}) {
    int flag = 0;

    for (var playListName in playList) {
      if (playListName
          .toString()
          .toLowerCase()
          .contains(currentText.toLowerCase())) {
        flag++;
      }
    }

    return flag;
  }

//

  int findSongName(
      {required List<Audio> playList, required String currentText}) {
    int flag = 0;

    for (var song in playList) {
      if (song.metas.title!.toLowerCase().contains(currentText.toLowerCase())) {
        flag++;
      }
    }

    return flag;
  }
}
