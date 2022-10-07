part of 'song_tile_bloc.dart';

class SongTileState {
  final bool isEmpty;

  SongTileState({required this.isEmpty});
}

class SongTileInitial extends SongTileState {
  SongTileInitial() : super(isEmpty: false);
}
