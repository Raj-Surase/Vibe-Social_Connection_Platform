import 'package:flutter/material.dart';
import 'package:vibe/Components/customtextfield.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class SessionCreate extends StatefulWidget {
  const SessionCreate({super.key});

  @override
  State<SessionCreate> createState() => _SessionCreateState();
}

class _SessionCreateState extends State<SessionCreate> {
  late TextEditingController _sessionNameController;
  late TextEditingController _sessionPasswordController;

  late bool _isPrivate = false;
  late bool _isInvite = false;

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
    _sessionNameController = TextEditingController();
    _sessionPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _sessionNameController = TextEditingController();
    _sessionPasswordController = TextEditingController();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            Navigator.pop(context);
          }),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.textHighEm,
            size: ValuesConstants.iconSize,
          ),
        ),
        titleSpacing: 0,
        title: const Text(
          "Start Session",
          style: AppTypography.textStyle14Bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              ValuesConstants.paddingLR,
              ValuesConstants.paddingTB,
              ValuesConstants.paddingLR,
              ValuesConstants.paddingTB),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: ValuesConstants.containerLarge,
                decoration: BoxDecoration(
                  color: AppColor.surfaceFG,
                  borderRadius:
                      BorderRadius.circular(ValuesConstants.radiusLarge),
                ),
              ),
              const SizedBox(
                height: ValuesConstants.paddingTB,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: ValuesConstants.containerSmallMedium,
                  width: ValuesConstants.screenWidth(context),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusSmall),
                    color: AppColor.primaryButton,
                  ),
                  child: const Center(
                    child: Text(
                      "Upload",
                      style: AppTypography.textStyle14Bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: ValuesConstants.paddingLR,
              ),
              const Text(
                "Session Name",
                style: AppTypography.textStyle14Bold,
              ),
              const SizedBox(
                height: ValuesConstants.paddingSmall,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ValuesConstants.radiusLarge),
                  color: AppColor.surfaceFG,
                  border: Border.all(color: AppColor.componentBorder),
                ),
                padding: const EdgeInsets.only(
                    left: ValuesConstants.paddingTB,
                    right: ValuesConstants.paddingTB),
                child: CustomTextField(
                    textFieldController: _sessionNameController,
                    hintText: "Session Name"),
              ),
              const SizedBox(height: ValuesConstants.paddingLR),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Private Session",
                    style: AppTypography.textStyle14Bold,
                  ),
                  SizedBox(
                    height: ValuesConstants.iconSize,
                    child: Switch(
                      thumbIcon: thumbIcon,
                      value: _isPrivate,
                      onChanged: (bool value) {
                        setState(() {
                          _isPrivate = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ValuesConstants.paddingTB),
              if (_isPrivate)
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.surfaceFG,
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusLarge),
                  ),
                  padding: const EdgeInsets.all(ValuesConstants.paddingTB),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Invite only",
                            style: AppTypography.textStyle14Bold,
                          ),
                          SizedBox(
                            height: ValuesConstants.iconSize,
                            child: Switch(
                              thumbIcon: thumbIcon,
                              value: _isInvite,
                              onChanged: (bool value) {
                                setState(() {
                                  _isInvite = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(ValuesConstants.paddingSmall),
                        child: Divider(
                          color: AppColor.surfaceBG,
                        ),
                      ),
                      const Text(
                        "Password",
                        style: AppTypography.textStyle14Bold,
                      ),
                      const SizedBox(
                        height: ValuesConstants.paddingSmall,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ValuesConstants.radiusLarge),
                            border: Border.all(color: AppColor.componentBorder),
                          ),
                          padding: const EdgeInsets.only(
                              left: ValuesConstants.paddingTB,
                              right: ValuesConstants.paddingTB),
                          child: CustomTextField(
                            textFieldController: _sessionPasswordController,
                            hintText: "Password",
                            isEnabled: !_isInvite,
                          )),
                      const SizedBox(
                        height: ValuesConstants.paddingSmall,
                      ),
                      if (_isInvite)
                        const Padding(
                          padding: EdgeInsets.only(
                              left: ValuesConstants.paddingSmall),
                          child: Text(
                            "The Session is invite only! You can only use password is  session is not invite only.",
                            style: AppTypography.textStyle8Normal,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: ElevatedButton(
          onPressed: () {
            _sessionNameController.text.trim();

            // Use the sessionName and isPrivate as needed
            // For example, you can pass them to another widget or process them further

            // Reset the input fields
            _sessionNameController.clear();
            setState(() {
              _isPrivate = false;
            });
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColor.primaryButton),
          ),
          child: const Text(
            'Create Session',
            style: AppTypography.textStyle14Bold,
          ),
        ),
      ),
    );
  }
}
