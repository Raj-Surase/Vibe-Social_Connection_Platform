import 'package:flutter/material.dart';

class ListProvider with ChangeNotifier {
  List<ListItem> _items = [];

  List<ListItem> get items => _items;

  void addItem(String title) {
    _items.add(ListItem(title));
    notifyListeners();
  }

  void removeItem(ListItem item) {
    _items.remove(item);
    notifyListeners();
  }
}

class ListItem {
  final String title;

  ListItem(this.title);
}
