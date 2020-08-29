// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class ImageGrid extends StatefulWidget{
//   final _index;
//   ImageGrid(this._index);

//   @override
//   _ImageGridState createState() => _ImageGridState();
// }

// class _ImageGridState extends State<ImageGrid> {
//   Uint8List image;
//   StorageReference photosReference =
//       FirebaseStorage.instance.ref().child('wallpapers');

//   Future<void> getImage() async {
//     int max_size = 7 * 1024 * 1024;
//     await photosReference
//         .child('wall_${widget._index}.jpg')
//         .getData(max_size)
//         .then((value) {
//       setState(() {
//         image = value;
//       });
//     }).catchError((onError) {});
//   }

//   Widget checkNull() {
//     if (image == null) {
//       return Center(
//         child: Text('No data'),
//       );
//     } else {
//       return Image.memory(
//         image,
//         fit: BoxFit.fill,
//       );
//     }
//   }

//   @override
//   void initState() {
//     getImage();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridTile(
//       child: checkNull(),
//     );
//   }
// }
