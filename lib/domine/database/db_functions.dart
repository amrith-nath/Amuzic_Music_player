import 'package:amuzic/domine/database/database_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/hive_flutter.dart';

//
//
//
String boxname = "songs";

class Mybox {
  static Box<List>? _box;
  static Box<List>? getinstance() => _box ??= Hive.box(boxname);
  static getDbSongs() {
    return _box!.get("musics") as List<LocalStorageSongs>;
  }

  static getDbSongWithId(
      {required List<LocalStorageSongs> songs, required String songId}) {
    return songs
        .firstWhere((element) => element.id.toString().contains(songId));
  }

  static convertToAudio({required List<LocalStorageSongs> allSongs}) {
    List<Audio> audioSongs = [];
    int index = 0;
    for (var song in allSongs) {
      audioSongs.add(
        Audio.file(song.uri.toString(),
            metas: Metas(
                id: song.id.toString(),
                artist: song.artist,
                title: song.title.toString(),
                album: index.toString())),
      );
      index++;
    }

    return audioSongs;
  }
}
