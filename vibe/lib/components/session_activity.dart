import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/components/user_tab.dart';

class SessionActivity extends StatelessWidget {
  const SessionActivity({
    super.key,
    this.sessionName = "Session",
    this.username = "User",
  });

  final String sessionName;
  final String username;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRoutes.SESSIONPLAYERROUTE);
      },
      child: Column(
        children: [
          Container(
            height: ValuesConstants.containerLarge,
            decoration: BoxDecoration(
              color: AppColor.surfaceFG,
              borderRadius: BorderRadius.circular(ValuesConstants.radiusLarge),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ValuesConstants.paddingSmall),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: ValuesConstants.containerSmall,
                  width: ValuesConstants.containerSmall,
                  decoration: BoxDecoration(
                    color: AppColor.surfaceFG,
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusLarge),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: ValuesConstants.paddingSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "widget.title",
                        style: AppTypography.textStyle10Bold(
                            color: AppColor.textHighEm),
                      ),
                      Text(
                        "widget.subtitle",
                        style: AppTypography.textStyle8Normal(
                            color: AppColor.textLowEm),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
