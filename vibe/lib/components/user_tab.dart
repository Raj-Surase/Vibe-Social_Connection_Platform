import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class UserTab extends StatefulWidget {
  const UserTab({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isClickable,
  });

  final String title;
  final String subtitle;
  final bool isClickable;

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isClickable) {
          context.push(AppRoutes.USERCHATROUTE, extra: widget.title);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: ValuesConstants.containerSmall,
            width: ValuesConstants.containerSmall,
            decoration: BoxDecoration(
              color: AppColor.surfaceFG,
              borderRadius: BorderRadius.circular(ValuesConstants.radiusLarge),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: ValuesConstants.paddingSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style:
                      AppTypography.textStyle10Bold(color: AppColor.textHighEm),
                ),
                Text(
                  widget.subtitle,
                  style:
                      AppTypography.textStyle8Normal(color: AppColor.textLowEm),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
