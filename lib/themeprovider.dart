import 'package:flutter/material.dart';

class Themeprovider with ChangeNotifier {
  bool _isdark = false;

  bool get dark => _isdark;

  void updateTheme(bool val) {
    _isdark = val;
    notifyListeners();
  }
}
