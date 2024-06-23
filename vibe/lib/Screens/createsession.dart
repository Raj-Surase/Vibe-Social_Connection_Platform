import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Components/customtextfield.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Database/firestore_service.dart';
import 'package:vibe/Provider/userprovider.dart';

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

  late Future<List<String>> _imageUrlsFuture;
  String? selectedImageUrl;
  int? selectedIndex;

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
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
    _imageUrlsFuture = _fetchImageUrls();
    _sessionNameController = TextEditingController();
    _sessionPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _sessionNameController = TextEditingController();
    _sessionPasswordController = TextEditingController();

    super.dispose();
  }

  Future<List<String>> _fetchImageUrls() async {
    ListResult result =
        await FirebaseStorage.instance.ref('/thumbnail/').listAll();
    List<String> urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));
    return urls;
  }

  void _pickImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(ValuesConstants.paddingLR),
                decoration: BoxDecoration(
                  color: AppColor.surfaceFG,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(ValuesConstants.radiusLarge)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<List<String>>(
                      future: _imageUrlsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            style: AppTypography.textStyle14Bold(
                                color: AppColor.textHighEm),
                          );
                        } else {
                          List<String> imageUrls = snapshot.data!;
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: imageUrls.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: ValuesConstants.paddingTB,
                              crossAxisSpacing: ValuesConstants.paddingTB,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              String imageUrl = imageUrls[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    selectedImageUrl = imageUrl;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(
                                        ValuesConstants.radiusMedium),
                                    color: selectedIndex == index
                                        ? AppColor.componentInactive
                                            .withOpacity(0.5)
                                        : AppColor.surfaceBG,
                                    image: DecorationImage(
                                        image: NetworkImage(imageUrl)),
                                  ),
                                  child: Center(
                                    child: selectedIndex == index
                                        ? Icon(
                                            Icons.check_rounded,
                                            color: AppColor.componentActive,
                                            size:
                                                ValuesConstants.containerSmall,
                                          )
                                        : Container(),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: ValuesConstants.paddingLR),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColor.primaryButton),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Select',
                          style: AppTypography.textStyle14Bold(
                              color: AppColor.textHighEm),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _continue() async {
    if (_sessionNameController.text.isNotEmpty && selectedImageUrl != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirestoreService firestoreService = FirestoreService();
        await firestoreService.addUser(
          user.uid,
          _sessionNameController.text,
          user.email!,
          selectedImageUrl!,
          // user.email!,
          false,
          false,
          0,
          0,
          [],
        );
        context.go('/navigator/home');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (!userProvider.isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).replace('/'); // Navigate to login page
          });
          return Container(
            color: AppColor.surfaceBG,
          ); // Return an empty container while redirecting
        }
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
              "Start Session",
              style: AppTypography.textStyle14Bold(color: AppColor.textHighEm),
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
                    onTap: _pickImage,
                    child: Container(
                      height: ValuesConstants.containerSmallMedium,
                      width: ValuesConstants.screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ValuesConstants.radiusSmall),
                        color: AppColor.primaryButton,
                      ),
                      child: Center(
                        child: Text(
                          "Upload",
                          style: AppTypography.textStyle14Bold(
                              color: AppColor.textHighEm),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingLR,
                  ),
                  Text(
                    "Session Name",
                    style: AppTypography.textStyle14Bold(
                        color: AppColor.textHighEm),
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
                      Text(
                        "Private Session",
                        style: AppTypography.textStyle14Bold(
                            color: AppColor.textHighEm),
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
                              Text(
                                "Invite only",
                                style: AppTypography.textStyle14Bold(
                                    color: AppColor.textHighEm),
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
                          Padding(
                            padding: const EdgeInsets.all(
                                ValuesConstants.paddingSmall),
                            child: Divider(
                              color: AppColor.surfaceBG,
                            ),
                          ),
                          Text(
                            "Password",
                            style: AppTypography.textStyle14Bold(
                                color: AppColor.textHighEm),
                          ),
                          const SizedBox(
                            height: ValuesConstants.paddingSmall,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ValuesConstants.radiusLarge),
                                border:
                                    Border.all(color: AppColor.componentBorder),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: ValuesConstants.paddingSmall),
                              child: Text(
                                "The Session is invite only! You can only use password is  session is not invite only.",
                                style: AppTypography.textStyle8Normal(
                                    color: AppColor.textHighEm),
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
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColor.primaryButton),
              ),
              child: Text(
                'Create Session',
                style:
                    AppTypography.textStyle14Bold(color: AppColor.textHighEm),
              ),
            ),
          ),
        );
      },
    );
  }
}
