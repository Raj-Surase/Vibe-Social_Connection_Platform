import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class UserChat extends StatefulWidget {
  const UserChat({required this.title, super.key});

  final String title;

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final TextEditingController _messageController = TextEditingController();

  final List messages = List.filled(50, "Hello...");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: ValuesConstants.containerMediumLarge,
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.textHighEm,
                size: ValuesConstants.iconSize,
              ),
              const SizedBox(
                width: ValuesConstants.paddingSmall,
              ),
              Container(
                height: ValuesConstants.iconSize,
                width: ValuesConstants.iconSize,
                decoration: BoxDecoration(
                  color: AppColor.textHighEm,
                  borderRadius:
                      BorderRadius.circular(ValuesConstants.radiusCircle),
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 0,
        title: Text(
          widget.title,
          style: AppTypography.textStyle14Bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(ValuesConstants.paddingLR, 0,
            ValuesConstants.paddingLR, ValuesConstants.paddingTB),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true, // Display messages from bottom to top
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: ValuesConstants.paddingTB),
                        child: Container(
                          height: ValuesConstants.containerSmall,
                          width: ValuesConstants.containerSmall,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ValuesConstants.radiusCircle),
                            color: AppColor.surfaceFG,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: ValuesConstants.paddingSmall,
                      ),
                      Text(
                        messages[index].toString(),
                        style: AppTypography.textStyle10Bold,
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ValuesConstants.radiusLarge),
                      color: AppColor.surfaceFG,
                    ),
                    padding: const EdgeInsets.only(
                        left: ValuesConstants.paddingTB,
                        right: ValuesConstants.paddingTB),
                    child: TextField(
                      controller: _messageController,
                      style: AppTypography.textStyle14Bold,
                      cursorRadius:
                          const Radius.circular(ValuesConstants.radiusSmall),
                      cursorColor: AppColor.componentActive,
                      decoration: InputDecoration(
                        hintText: 'Enter your message...',
                        hintStyle: AppTypography.textStyle14Normal,
                        border: InputBorder.none,

                        // fillColor: AppColor.surfaceFG,
                        // filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: ValuesConstants.paddingSmall),
                IconButton(
                  onPressed: (() {}),
                  icon: Icon(
                    Icons.send_rounded,
                    color: AppColor.componentActive,
                    size: ValuesConstants.paddingLR,
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
