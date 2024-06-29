import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/screens/session/player_queue/player_queue_vm.dart';

class QueueListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QueueListViewModel>.reactive(
      viewModelBuilder: () => QueueListViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
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
            actions: [
              TextButton(
                onPressed: viewModel.canSave
                    ? () => viewModel.saveAndRedirect(context)
                    : null,
                child: Text(
                  "Save",
                  style: AppTypography.textStyle14Bold(
                      color: AppColor.primaryButton),
                ),
              ),
            ],
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
                  child: viewModel.items.isEmpty
                      ? Center(
                          child: Text(
                            "Queue is empty.",
                            style: AppTypography.textStyle14Normal(
                                color: AppColor.textHighEm),
                          ),
                        )
                      : ReorderableListView(
                          proxyDecorator: proxyDecorator,
                          dragStartBehavior: DragStartBehavior.down,
                          onReorder: viewModel.onReorder,
                          children: viewModel.items.map((item) {
                            return Container(
                              key: ValueKey(item),
                              margin: EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    ValuesConstants.radiusMedium,
                                  ),
                                ),
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
                                    viewModel.removeItem(item);
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        isSecure: false,
                        hintText: "Video Link",
                        controller: viewModel.playlistController,
                      ),
                    ),
                    SizedBox(
                      width: ValuesConstants.paddingTB,
                    ),
                    ElevatedButton(
                      onPressed: viewModel.addItem,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.primaryButton),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ValuesConstants.radiusMedium),
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
      },
    );
  }
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
