part of 'song_tile_bloc.dart';

@immutable
abstract class SongTileEvent {}

class GetFavInfoEvent extends SongTileEvent {
  final String songId;

  GetFavInfoEvent({required this.songId});
}

class AddFavEvent extends SongTileEvent {}

class DeleteFavEvent extends SongTileEvent {}
