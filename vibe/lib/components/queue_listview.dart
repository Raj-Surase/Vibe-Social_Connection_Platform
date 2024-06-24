import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class QueueListView extends StatefulWidget {
  @override
  State<QueueListView> createState() => _QueueListViewState();
}

class _QueueListViewState extends State<QueueListView> {
  late TextEditingController _playlistController;

  @override
  void initState() {
    super.initState();

    _playlistController = TextEditingController();
  }

  @override
  void dispose() {
    _playlistController = TextEditingController();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            context.pop();
          }),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.textHighEm,
            size: ValuesConstants.iconSize,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "Queue",
          style: AppTypography.textStyle14Bold(color: AppColor.textHighEm),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          ValuesConstants.paddingLR,
          ValuesConstants.paddingSmall,
          ValuesConstants.paddingLR,
          ValuesConstants.containerSmall,
        ),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ListProvider>(
                builder: (context, listProvider, child) {
                  return ReorderableListView(
                    proxyDecorator: proxyDecorator,
                    dragStartBehavior: DragStartBehavior.down,
                    onReorder: (int oldIndex, int newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final item = listProvider.items.removeAt(oldIndex);
                      listProvider.items.insert(newIndex, item);
                      listProvider.notifyListeners();
                    },
                    children: listProvider.items.map((item) {
                      return Container(
                        key: ValueKey(item),
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              ValuesConstants.radiusMedium,
                            ),
                          ),
                          // key: ValueKey(item),
                          tileColor: AppColor.surfaceFG,
                          leading: Icon(
                            Icons.drag_handle,
                            color: AppColor.textLowEm,
                          ),
                          title: Text(
                            item.title,
                            style: AppTypography.textStyle12Normal(
                                color: AppColor.textHighEm),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete,
                                color: AppColor.componentError),
                            onPressed: () {
                              listProvider.removeItem(item);
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    isSecure: false,
                    hintText: "Video Link",
                    controller: _playlistController,
                  ),
                ),
                SizedBox(
                  width: ValuesConstants.paddingTB,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_playlistController.text.isNotEmpty) {
                      Provider.of<ListProvider>(context, listen: false)
                          .addItem(_playlistController.text);
                      _playlistController.clear();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColor.primaryButton),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ValuesConstants.radiusMedium),
                      ),
                    ),
                  ),
                  child: Text(
                    'Add',
                    style: AppTypography.textStyle12Bold(
                        color: AppColor.textHighEm),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final double elevation = lerpDouble(0, 6, animValue)!;
      return Material(
        elevation: elevation,
        color: AppColor.surfaceFG,
        shadowColor: AppColor.surfaceFG,
        child: child,
      );
    },
    child: child,
  );
}
