import 'package:flutter/material.dart';

class BuilderData extends ChangeNotifier {
  int count = 0;

  void inc() {
    ++count;
    notifyListeners();
  }
}
