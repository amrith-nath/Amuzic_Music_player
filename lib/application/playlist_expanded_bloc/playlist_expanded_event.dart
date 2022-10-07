part of 'playlist_expanded_bloc.dart';

@immutable
abstract class PlaylistExpandedEvent {
  final dynamic playListName;

  const PlaylistExpandedEvent({required this.playListName});
}

class OnGetPlayListSongs extends PlaylistExpandedEvent {
  const OnGetPlayListSongs({required super.playListName});
}

class OnPlayListSongDelete extends PlaylistExpandedEvent {
  final LocalStorageSongs song;
  const OnPlayListSongDelete({required this.song, required super.playListName});
}
