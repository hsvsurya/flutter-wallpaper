// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
// import 'package:dio/dio.dart';
import 'package:toast/toast.dart';
// import 'package:wallpaper/screens/wallpaper_screen.dart';
// import 'package:image_picker_saver/image_picker_saver.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:wallpaper/models/wallpaper.dart';

class DownloadScreen extends StatefulWidget {
  final String url;
  final int id;
  DownloadScreen({this.url, this.id});
  static const routeName = '/download';

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  Widget build(BuildContext context) {
    // Map downloadUrl = url.data();
    // final data = Provider.of<Data>(context).list;
    void download(String url) async {
      try {
        Toast.show(
          'Dowloading....',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
        );
        // Saved with this method.
        // var res = await http.get(url);
        var imageId = await ImageDownloader.downloadImage(
          url,
          destination: AndroidDestinationType.directoryPictures
            ..subDirectory('Klao/$url.jpg'),
        );
        if (imageId == null) {
          return Toast.show(
            'Check your network or try again',
            context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            textColor: Theme.of(context).errorColor,
          );
        }
        if (imageId != null) {
          var path = await ImageDownloader.findPath(imageId);
          var fileName = await ImageDownloader.findName(imageId);
          // var path = await ImageDownloader.findPath(imageId);
          var size = await ImageDownloader.findByteSize(imageId);
          var mimeType = await ImageDownloader.findMimeType(imageId);
          await ImageDownloader.open(path).catchError((error) {
            if (error is PlatformException) {
              if (error.code == "preview_error") {
                // print(error.message);
              }
            }
          });
        }

        // Below is a method of obtaining saved image information.

      } on PlatformException catch (error) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$error',
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: GridTile(
        child: Container(
          child: Hero(
            tag: widget.id,
            child: CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: widget.url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.teal,
              ],
              begin: Alignment.topLeft,
              end: Alignment.center,
            ),
          ),
          child: FlatButton.icon(
            icon: Icon(
              Icons.file_download,
              color: Colors.white,
            ),
            label: Text(
              'Download',
              style: TextStyle(color: Colors.white),
            ),
            // color: Colors.black45,
            onPressed: () {
              download(widget.url);
            },
          ),
        ),
      ),
    );
  }
}
