import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/screens/splash_screen.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
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
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: const SplashSreen(),
            );
          });
    });
  }
}
