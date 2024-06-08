import 'package:flutter/material.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class CustomButtonWidget extends StatelessWidget {
  final List<ButtonData> buttons;

  const CustomButtonWidget({Key? key, required this.buttons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ValuesConstants.radiusLarge),
        color: AppColor.surfaceFG,
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: Column(
          children: buttons
              .map((button) => Column(
                    children: [
                      InkWell(
                        onTap: button.onTap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  button.icon,
                                  color: AppColor.textHighEm,
                                  size: ValuesConstants.iconSize,
                                ),
                                SizedBox(
                                  width: ValuesConstants.paddingSmall,
                                ),
                                Text(
                                  button.text,
                                  style: AppTypography.textStyle10Bold,
                                ),
                              ],
                            ),
                            if (button.trailingText != null)
                              Text(
                                button.trailingText!,
                                style: AppTypography.textStyle10Bold,
                              )
                            else if (button.trailingSwitch != null)
                              button.trailingSwitch!
                            else
                              SizedBox.shrink(),
                          ],
                        ),
                      ),
                      if (button != buttons.last)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: ValuesConstants.paddingSmall,
                              bottom: ValuesConstants.paddingSmall),
                          child: Divider(
                            color: AppColor.componentBorder,
                          ),
                        ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class ButtonData {
  final IconData icon;
  final String text;
  final String? trailingText;
  final Widget? trailingSwitch;
  final VoidCallback onTap;

  ButtonData({
    required this.icon,
    required this.text,
    this.trailingText,
    this.trailingSwitch,
    required this.onTap,
  });
}

class CustomSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomSwitch(
      {Key? key, required this.initialValue, required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _value;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(
          Icons.check,
          size: ValuesConstants.iconSize,
        );
      }
      return const Icon(
        Icons.close,
        size: ValuesConstants.iconSize,
      );
    },
  );

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Switch(
        value: _value,
        thumbIcon: thumbIcon,
        onChanged: (bool value) {
          setState(() {
            _value = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
