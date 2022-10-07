import 'package:amuzic/domine/database/database_model.dart';
import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'playlist_expanded_event.dart';
part 'playlist_expanded_state.dart';

class PlaylistExpandedBloc
    extends Bloc<PlaylistExpandedEvent, PlaylistExpandedState> {
  PlaylistExpandedBloc() : super(PlaylistExpandedInitial()) {
    on<OnGetPlayListSongs>((event, emit) async {
      List playlistSongs = await Mybox.getPlayListSongs(event.playListName);

      emit(PlaylistExpandedState(
          playListSongs: playlistSongs, isDeleteSelectOn: false));
    });
    on<OnPlayListSongDelete>((event, emit) async {
      Mybox.deleteSongFoRPlayList(
          playListName: event.playListName, song: event.song);

      List playlistSongs = await Mybox.getPlayListSongs(event.playListName);

      emit(PlaylistExpandedState(
          playListSongs: playlistSongs, isDeleteSelectOn: false));
    });
  }
}
