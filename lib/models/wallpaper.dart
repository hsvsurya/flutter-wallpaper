import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  Map<dynamic, dynamic> _list;

  get list {
    if (_list.isEmpty) {
      return;
    }
    return _list;
  }
}
