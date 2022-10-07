import 'package:amuzic/domine/database/database_model.dart';
import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'song_tile_event.dart';
part 'song_tile_state.dart';

class SongTileBloc extends Bloc<SongTileEvent, SongTileState> {
  SongTileBloc() : super(SongTileInitial()) {
    on<GetFavInfoEvent>((event, emit) {
      var box = Mybox.getinstance();

      List? favSongs = box!.get('favourites');
      if (favSongs!
          .where((element) => element.id.toString() == event.songId)
          .isEmpty) {
        emit(SongTileState(isEmpty: true));
      }
      if (favSongs
          .where((element) => element.id.toString() == event.songId)
          .isNotEmpty) {
        emit(SongTileState(isEmpty: false));
      }
      ;
    });
    on<AddFavEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<DeleteFavEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
