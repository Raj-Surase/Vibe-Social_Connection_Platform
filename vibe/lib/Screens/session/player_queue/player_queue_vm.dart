import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/provider/list_provide.dart';

class QueueListViewModel extends ChangeNotifier {
  final TextEditingController playlistController = TextEditingController();
  late ListProvider _listProvider;

  QueueListViewModel() {
    _listProvider = ListProvider();
  }

  List<ListItem> get items => _listProvider.items;

  bool get canSave => _listProvider.items.isNotEmpty;

  void addItem() {
    if (playlistController.text.isNotEmpty) {
      _listProvider.addItem(playlistController.text);
      playlistController.clear();
      notifyListeners();
    }
  }

  void removeItem(ListItem item) {
    _listProvider.removeItem(item);
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _listProvider.items.removeAt(oldIndex);
    _listProvider.items.insert(newIndex, item);
    notifyListeners();
  }

  void saveAndRedirect(BuildContext context) {
    // Save to database here
    GoRouter.of(context).push(AppRoutes.SESSIONPLAYERROUTE);
  }
}
