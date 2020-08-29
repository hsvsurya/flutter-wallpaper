import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:wallpaper/models/wallpaper.dart';
import 'package:Klao/screens/downloader_screen.dart';
import 'package:Klao/screens/wallpaper_screen.dart';
// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klao',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        // primaryColor: Colors.blue,
        primaryColorBrightness: Brightness.dark,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              color: Colors.amber,
              textTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontFamily: 'Dancing Script',
                    fontWeight: FontWeight.bold),
              ),
              iconTheme: IconThemeData(
                color: Colors.lightBlueAccent,
                opacity: 200,
                size: 30,
              ),
            ),
      ),
      home: WallpaperScreen(),
      routes: {
        '/mainScreen': (ctx) => WallpaperScreen(),
        DownloadScreen.routeName: (ctx) => DownloadScreen(),
      },
    );
  }
}

// ChangeNotifierProvider(
//       create: (context) => Data(),
//           child:
