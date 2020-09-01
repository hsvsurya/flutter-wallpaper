import 'dart:ui';

import 'package:Klao/screens/downloader_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:wallpaper/models/wallpaper.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:Klao/screens/downloader_screen.dart';
// import 'package:image_downloader/image_downloader.dart';
// import 'package:toast/toast.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

class WallpaperScreen extends StatefulWidget {
  static int count = 0;
  @override
  _WallpaperScreenState createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  Widget _buildGrid(BuildContext context, DocumentSnapshot ss, int ind) {
    Map docs = ss.data();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.amber,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          child: Hero(
            // s,
            tag: docs['id'],
            child: Material(
              child: InkWell(
                splashColor: Colors.amber,
                child: Container(
                  decoration: BoxDecoration(
                    color: changeColor(WallpaperScreen.count),
                  ),
                  child: GridTile(
                    child: Image.network(
                      docs['imageUrl'].toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) {
                        return DownloadScreen(
                          url: docs['imageUrl'],
                          id: docs['id'],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color changeColor(int c) {
    if (c == 0) {
      c = 1;
      return Colors.indigo;
    } else if (c == 1) {
      c = 2;
      return Colors.blueAccent;
    } else {
      c = 0;
      return Colors.deepPurple;
    }
  }

  // @override
  // void didChangeDependencies() {
  //   precacheImage(image.image, context);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // ImageGrid g;
    // final data = Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            // height: 90,
            child: Text(
              'Klao',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 40,
              ),
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white10,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          right: 20,
          left: 20,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('wall')
              .orderBy('id', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, ind) {
                return Container(
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: _buildGrid(context, snapshot.data.documents[ind], ind),
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          },
        ),
      ),
      // backgroundColor: Colors.white,
    );
  }
}

// CachedNetworkImage(
//             placeholder: (context, url) => Center(
//               child: CircularProgressIndicator(),
//             ),
//             filterQuality: FilterQuality.medium,
//             imageUrl: docs['imageUrl'],
//             fadeInCurve: Curves.easeIn,
//           )

// Navigator(
//                     initialRoute: '/',
//                     onGenerateRoute: (path) => PageRouteBuilder(
//                       pageBuilder: (context, _, __) {
//                         return DownloadScreen(
//                           url: docs['imageUrl'],
//                           id: docs['id'],
//                         );
//                       },
//                     ),
//                     observers: [
//                       HeroController(),
//                     ],
//                   );
