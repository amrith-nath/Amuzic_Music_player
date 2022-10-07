part of 'playlist_screen_bloc.dart';

@immutable
abstract class PlaylistScreenEvent {}

class GetPlayListEvent extends PlaylistScreenEvent {}

class AddPlayListEvent extends PlaylistScreenEvent {
  final dynamic playlistname;

  AddPlayListEvent({required this.playlistname});
}

class DeletePlayListEvent extends PlaylistScreenEvent {
  final dynamic playlistname;

  DeletePlayListEvent({required this.playlistname});
}

class EditPlayListEvent extends PlaylistScreenEvent {
  final dynamic playlistname;
  final dynamic playlistNewname;

  EditPlayListEvent(
      {required this.playlistname, required this.playlistNewname});
}
