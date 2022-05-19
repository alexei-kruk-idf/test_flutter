import 'package:flutter/material.dart';

class ListData extends ChangeNotifier {
  List<Widget> list = [];

  void add(Widget widget) {
    list.add(widget);
    notifyListeners();
  }
}
