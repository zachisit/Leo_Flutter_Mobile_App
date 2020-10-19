import 'package:flutter/material.dart';

class ImageActionProvider with ChangeNotifier {
  bool _isPlaying = false;
  String _imagePath = 'assets/images/cat_normal.png';

  bool get isPlayingStatus => _isPlaying;
  String get image => _imagePath;

  void setPlayingStatus(bool status) {
    switch (status) {
      case true:
        _imagePath = 'assets/images/cat_active.png';
        _isPlaying = true;
        break;
      case false:
        _imagePath = 'assets/images/cat_normal.png';
        _isPlaying = false;
        break;
    }
    notifyListeners();
  }
}