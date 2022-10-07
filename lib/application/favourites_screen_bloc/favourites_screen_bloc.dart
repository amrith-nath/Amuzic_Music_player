import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favourites_screen_event.dart';
part 'favourites_screen_state.dart';

class FavouritesScreenBloc
    extends Bloc<FavouritesScreenEvent, FavouritesScreenState> {
  FavouritesScreenBloc() : super(FavouritesScreenInitial(favSongs: [])) {
    on<GetFavSongsEvent>((event, emit) {
      List favSongs = Mybox.getPlayListSongs('favourites');

      emit(FavouritesScreenState(favSongs: favSongs));
    });
  }
}
