import 'dart:developer';

import 'package:amuzic/domine/database/database_model.dart';
import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetSongs {
  static fetchSongs() async {
    List<SongModel> fetchedSongs = [];
    List<SongModel> allSongs = [];
    List<LocalStorageSongs> dbSongs = [];
    List<LocalStorageSongs> mappedSongs = [];
    List<Audio> audioSongs = [];

    final _audioQuerry = OnAudioQuery();
    final myBox = Mybox.getinstance();

    bool permissionStatus = await _audioQuerry.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuerry.permissionsRequest();
    }
    fetchedSongs = await _audioQuerry.querySongs();
    //
    for (var element in fetchedSongs) {
      if (element.fileExtension == 'mp3') {
        allSongs.add(element);
      }
    }
    //mapped songs
    mappedSongs = allSongs
        .map(
          (song) => LocalStorageSongs(
              title: song.title,
              artist: song.artist,
              uri: song.uri,
              duration: song.duration,
              id: song.id),
        )
        .toList();
    //
    await myBox!.put("musics", mappedSongs);
    if (myBox.keys.contains("musics")) {
      log('musics is saved but fav didnt');
    }
    if (myBox.keys.contains("favorites")) {
      log('My bad');
    }
    if (myBox.keys.contains("favourites")) {
      log('just testing ');
    }
    dbSongs = Mybox.getDbSongs();
    //
    for (var element in dbSongs) {
      audioSongs.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist,
          ),
        ),
      );
    }
  }
}
