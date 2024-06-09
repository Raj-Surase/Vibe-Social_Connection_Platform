import 'package:flutter/material.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  final TextEditingController _messageController = TextEditingController();
  final List messages = List.filled(50, "Hello...");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.containerMedium,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: ValuesConstants.containerLarge,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusLarge),
                    color: AppColor.surfaceFG,
                  ),
                ),
                const SizedBox(
                  height: ValuesConstants.paddingTB,
                ),
                Text(
                  "Session Name",
                  style: AppTypography.textStyle14Bold,
                ),
                const SizedBox(
                  height: ValuesConstants.paddingSmall,
                ),
                Text(
                  "Views | Started on",
                  style: AppTypography.textStyle8Normal,
                ),
                const SizedBox(
                  height: ValuesConstants.paddingTB,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: ValuesConstants.containerSmall,
                          width: ValuesConstants.containerSmall,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ValuesConstants.radiusCircle),
                            color: AppColor.surfaceFG,
                          ),
                        ),
                        const SizedBox(
                          width: ValuesConstants.paddingSmall,
                        ),
                        Text(
                          "Username",
                          style: AppTypography.textStyle10Bold,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: (() {}),
                      style: ButtonStyle(
                        fixedSize: const WidgetStatePropertyAll(
                          Size(ValuesConstants.containerMediumLarge,
                              ValuesConstants.containerSmall),
                        ),
                        backgroundColor:
                            WidgetStatePropertyAll(AppColor.surfaceFG),
                      ),
                      child: Text(
                        "Add Friend",
                        style: AppTypography.textStyle10Bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
