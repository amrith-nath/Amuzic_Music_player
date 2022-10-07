import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<GetSongEvent>((event, emit) async {
      List<Audio> allSongs = await Mybox.getDBAudioSongs();

      emit(HomeScreenState(allSongs: allSongs));
    });
  }
}
