import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:amuzic/screens/splash_screen.dart';
import 'package:amuzic/theme/app_theme.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,

      theme: MyTheme.darkTheme,
      darkTheme: MyTheme.darkTheme,
      // home: const SplashSreen(),
      home: const SplashSreen(),
    );
  }
}
