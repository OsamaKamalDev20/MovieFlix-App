import 'package:flutter/material.dart';

class MovieBannerProvider extends ChangeNotifier {
  int currentIndex = 0;
  final List<String> movieBanner = [
    "assets/images/movie/banner_1.jpg",
    "assets/images/movie/banner_2.jpg",
    "assets/images/movie/banner_3.jpg",
    "assets/images/movie/banner_4.jpg",
  ];

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
