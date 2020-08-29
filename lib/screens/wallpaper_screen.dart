import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:wallpaper/models/wallpaper.dart';
import 'package:wallpaper/screens/downloader_screen.dart';
// import 'package:provider/provider.dart';

class WallpaperScreen extends StatefulWidget {
  @override
  _WallpaperScreenState createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  final count = 0;

  Widget _buildGrid(BuildContext context, DocumentSnapshot ss, int ind) {
    Map docs = ss.data();
    // final images = Provider.of<Data>(context).list;
    // images.add(docs['imageUrl']);
    // var s = FirebaseStorage.instance
    //     .ref()
    //     .child('wallpapers')
    //     .getDownloadURL()
    //     .toString();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.network(
          // s,
          docs['imageUrl'].toString(),
          fit: BoxFit.fill,
        ),
        // child: Text(s),
      ),
    );
  }

  Color changeColor(int c) {
    if (c == 0) {
      c++;
      return Colors.orange;
    } else if (c == 1) {
      c++;
      return Colors.blueAccent;
    } else {
      c = 0;
      return Colors.deepPurple;
    }
  }

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
              'Wallpaper',
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
                childAspectRatio: 5.4 / 8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, ind) {
                return Container(
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                    color: changeColor(count),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    onTap: () {
                      // data.load();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            DocumentSnapshot redirect =
                                snapshot.data.documents[ind];
                            Map redir = redirect.data();
                            return DownloadScreen(
                                url: redir['imageUrl'].toString());
                          },
                        ),
                      );
                    },
                    child:
                        _buildGrid(context, snapshot.data.documents[ind], ind),
                  ),
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
