import 'dart:ffi';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Database/firestore_service.dart';
import 'package:vibe/Provider/userprovider.dart';

class ProfileInit extends StatefulWidget {
  const ProfileInit({super.key});

  @override
  State<ProfileInit> createState() => _ProfileInitState();
}

class _ProfileInitState extends State<ProfileInit> {
  late TextEditingController usernameController;
  late Future<List<String>> _imageUrlsFuture;
  String? selectedImageUrl;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    _imageUrlsFuture = _fetchImageUrls();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  Future<List<String>> _fetchImageUrls() async {
    ListResult result = await FirebaseStorage.instance.ref('/').listAll();
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
                              crossAxisCount: 3,
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
    if (usernameController.text.isNotEmpty && selectedImageUrl != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirestoreService firestoreService = FirestoreService();
        await firestoreService.addUser(
          user.uid,
          usernameController.text,
          user.email!,
          selectedImageUrl!,
          // user.email!,
          false,
          false,
          0,
          0,
          [],
        );
        context.go(AppRoutes.HOMEROUTE);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create your Profile",
              style: AppTypography.textStyle24Bold(color: AppColor.textHighEm),
            ),
            const SizedBox(
              height: ValuesConstants.paddingLR,
            ),
            GestureDetector(
              onTap: _pickImage,
              child: selectedImageUrl == null
                  ? Container(
                      height: ValuesConstants.containerLarge,
                      width: ValuesConstants.containerLarge,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ValuesConstants.radiusCircle),
                        color: AppColor.surfaceFG,
                      ),
                      child: Center(
                          child: Text(
                        "Upload",
                        style: AppTypography.textStyle14Bold(
                            color: AppColor.textHighEm),
                      )),
                    )
                  : Container(
                      height: ValuesConstants.containerLarge,
                      width: ValuesConstants.containerLarge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(selectedImageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: ValuesConstants.containerMedium,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style:
                      AppTypography.textStyle14Bold(color: AppColor.textHighEm),
                ),
                const SizedBox(
                  height: ValuesConstants.paddingSmall,
                ),
                CustomTextField(
                  hintText: "Username",
                  controller: usernameController,
                  isUsername: true,
                ),
              ],
            ),
            const SizedBox(
              height: ValuesConstants.paddingLR,
            ),
            SizedBox(
              width: ValuesConstants.screenWidth(context),
              height: ValuesConstants.containerSmallMedium,
              child: TextButton(
                onPressed: _continue,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppColor.primaryButton),
                ),
                child: Text(
                  'Continue',
                  style:
                      AppTypography.textStyle14Bold(color: AppColor.textHighEm),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}