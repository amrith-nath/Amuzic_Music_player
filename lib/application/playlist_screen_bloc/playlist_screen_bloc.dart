import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'playlist_screen_event.dart';
part 'playlist_screen_state.dart';

class PlaylistScreenBloc
    extends Bloc<PlaylistScreenEvent, PlaylistScreenState> {
  PlaylistScreenBloc() : super(PlaylistScreenInitial()) {
    on<GetPlayListEvent>((event, emit) async {
      List keys = await Mybox.getKeys();
      List newKeys = [];
      for (var e in keys) {
        if (e != "musics" && e != "favourites" && e != "recent") {
          newKeys.add(e);
        }
      }

      emit(PlaylistScreenState(playListnames: newKeys));
    });

    on<DeletePlayListEvent>((event, emit) async {
      Mybox.deletePlaylist(event.playlistname);

      List keys = await Mybox.getKeys();
      List newKeys = [];
      for (var e in keys) {
        if (e != "musics" && e != "favourites" && e != "recent") {
          newKeys.add(e);
        }
      }
      emit(PlaylistScreenState(playListnames: newKeys));
    });
    on<EditPlayListEvent>((event, emit) async {
      List playList = await Mybox.getPlayListSongs(event.playlistname);

      Mybox.addSongsList(songs: playList, playListName: event.playlistNewname);
      Mybox.deletePlaylist(event.playlistname);
      List keys = await Mybox.getKeys();
      List newKeys = [];
      for (var e in keys) {
        if (e != "musics" && e != "favourites" && e != "recent") {
          newKeys.add(e);
        }
      }
      emit(PlaylistScreenState(playListnames: newKeys));
    });
    on<AddPlayListEvent>((event, emit) async {
      await Mybox.addSongsList(songs: [], playListName: event.playlistname);

      List keys = await Mybox.getKeys();
      List newKeys = [];
      for (var e in keys) {
        if (e != "musics" && e != "favourites" && e != "recent") {
          newKeys.add(e);
        }
      }
      emit(PlaylistScreenState(playListnames: newKeys));
    });
  }
}
