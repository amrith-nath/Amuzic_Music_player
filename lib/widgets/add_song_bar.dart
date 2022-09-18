import 'dart:ui';

import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/fonts/fonts.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddSongBar extends StatelessWidget {
  AddSongBar({required this.playListName, Key? key}) : super(key: key);

  String playListName;

  @override
  Widget build(BuildContext context) {
    final lTheme = DynamicTheme.of(context)!.themeId == 0 ? true : false;
    final box = Mybox.getinstance();

    return SolidBottomSheet(
      draggableBody: false,
      showOnAppear: true,
      maxHeight: 300,
      headerBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: lTheme
                  ? Colors.grey.shade400.withOpacity(0.5)
                  : Colors.grey.shade900.withOpacity(0.5),
            ),
          ),
        ),
      ),
      body: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: lTheme
                  ? Colors.grey.shade400.withOpacity(0.5)
                  : Colors.grey.shade900.withOpacity(0.5),
            ),
            child: ValueListenableBuilder(
                valueListenable: box!.listenable(),
                builder: (context, value, child) {
                  final playlistSongs = box.get(playListName);
                  final allsongs = box.get("musics") as List<LocalStorageSongs>;

                  return ListView.builder(
                    itemCount: allsongs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var temp = playlistSongs!
                          .where(
                            (element) =>
                                element.id.toString() ==
                                allsongs[index].id.toString(),
                          )
                          .toList();
                      return temp.isEmpty
                          ? ListTile(
                              leading: CircleAvatar(
                                backgroundImage: const AssetImage(
                                  'assets/images/red_lady.png',
                                ),
                                child: QueryArtworkWidget(
                                  nullArtworkWidget: const SizedBox(),
                                  artworkFit: BoxFit.cover,
                                  id: allsongs[index].id!,
                                  type: ArtworkType.AUDIO,
                                ),
                              ),
                              title:
                                  MyFont.montSemiBold13(allsongs[index].title!),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.arrow_circle_up,
                                  color: Colors.red.shade900,
                                ),
                                onPressed: (() {
                                  playlistSongs.add(allsongs[index]);
                                  box.put(playListName, playlistSongs);
                                }),
                              ),
                            )
                          : const SizedBox();
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
}
