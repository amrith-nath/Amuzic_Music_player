part of 'playlist_expanded_bloc.dart';

class PlaylistExpandedState {
  final List playListSongs;
  final bool isDeleteSelectOn;

  PlaylistExpandedState(
      {required this.playListSongs, required this.isDeleteSelectOn});
}

class PlaylistExpandedInitial extends PlaylistExpandedState {
  PlaylistExpandedInitial() : super(playListSongs: [], isDeleteSelectOn: false);
}
