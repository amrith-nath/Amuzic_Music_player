part of 'home_screen_bloc.dart';

class HomeScreenState {
  final List<Audio> allSongs;

  HomeScreenState({required this.allSongs});
}

class HomeScreenInitial extends HomeScreenState {
  HomeScreenInitial() : super(allSongs: []);
}
