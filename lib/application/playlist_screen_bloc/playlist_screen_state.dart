part of 'playlist_screen_bloc.dart';

class PlaylistScreenState {
  final List playListnames;

  PlaylistScreenState({required this.playListnames});
}

class PlaylistScreenInitial extends PlaylistScreenState {
  PlaylistScreenInitial() : super(playListnames: []);
}
