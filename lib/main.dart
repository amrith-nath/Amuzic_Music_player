import 'dart:developer';

import 'package:amuzic/application/favourites_screen_bloc/favourites_screen_bloc.dart';
import 'package:amuzic/application/home_screen_bloc/home_screen_bloc.dart';
import 'package:amuzic/application/login_screen_cubit/login_screen_cubit.dart';
import 'package:amuzic/application/playlist_screen_bloc/playlist_screen_bloc.dart';
import 'package:amuzic/application/song_tile_bloc/song_tile_bloc.dart';
import 'package:amuzic/domine/database/database_model.dart';
import 'package:amuzic/infrastructure/song_repo/songs_repo.dart';
import 'package:amuzic/presentation/screens/splash_screen/splash_screen.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();

  await Hive.initFlutter();
  Hive.registerAdapter(LocalStorageSongsAdapter());
  await Hive.openBox<List>(boxname);
  final box = Mybox.getinstance();
  //
  List<dynamic> songKeys = box!.keys.toList();
  if (!songKeys.contains("favourites")) {
    List<dynamic> likedSongs = [];
    await box.put("favourites", likedSongs);
  }
  if (!songKeys.contains("recent")) {
    List<LocalStorageSongs> recentSongs = [];
    await box.put("recent", recentSongs);
    log("recent created");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return DynamicTheme(
          themeCollection: MyTheme.themeCollection,
          defaultThemeId: MyTheme.lightThemeId,
          builder: (context, theme) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => LoginScreenCubit(),
                ),
                BlocProvider(
                  create: (context) => SongTileBloc(),
                ),
                BlocProvider(
                  create: (context) => HomeScreenBloc(),
                ),
                BlocProvider(
                  create: (context) => FavouritesScreenBloc(),
                ),
                BlocProvider(
                  create: (context) => PlaylistScreenBloc(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: theme,
                home: SplashSreen(),
              ),
            );
          });
    });
  }
}
