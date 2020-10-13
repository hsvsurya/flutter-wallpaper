import 'package:flutter/material.dart';

class Wallpaper {
  final int id;
  final String imageUrl;

  Wallpaper(this.id, this.imageUrl);
}

class Walls with ChangeNotifier {
  List<Wallpaper> walls = [];
}
