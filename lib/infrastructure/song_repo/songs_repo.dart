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

  static addSongToPlayList(
      {required LocalStorageSongs song, required String playListName}) async {
    List? songs = _box!.get(playListName);

    songs!.add(song);

    await _box!.put(playListName, songs);
  }

  static addSongsList(
      {required List songs, required dynamic playListName}) async {
    await _box!.put(playListName, songs);
  }

  static deletePlaylist(dynamic key) {
    _box!.delete(key);
  }

  static deleteSongFoRPlayList(
      {required LocalStorageSongs song, required String playListName}) async {
    List? songs = _box!.get(playListName);

    songs!
        .removeWhere((element) => element.id.toString() == song.id.toString());

    await _box!.put(playListName, songs);
  }

  static getKeys() async {
    var allKeys = _box!.keys.toList();

    return allKeys;
  }

  static getPlayListSongs(String playListname) {
    List? songs = _box!.get(playListname);

    return songs;
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

  static getDBAudioSongs() async {
    List<LocalStorageSongs> dbSongs = await getDbSongs();

    List<Audio> audioSongs = [];

    for (var song in dbSongs) {
      audioSongs.add(
        Audio.file(song.uri.toString(),
            metas: Metas(
              id: song.id.toString(),
              artist: song.artist,
              title: song.title.toString(),
            )),
      );
    }
    return audioSongs;
  }
}
