import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
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
                                    shape: BoxShape.circle,
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
                          // if (selectedImageUrl != null) {
                          //   await _firestore
                          //       .collection('users')
                          //       .doc(_auth.currentUser?.uid)
                          //       .update({
                          //     'profile_picture': _selectedImageUrl,
                          //   });
                          //   setState(() {
                          //     _image = null;
                          //   });
                          // }
                          Navigator.pop(context);
                          ;
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

  void _continue() {
    if (usernameController.text.isNotEmpty && selectedImageUrl != null) {
      // Save the username and image to Firestore (example implementation)
      User? user = context.read<UserProvider>().user;
      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': usernameController.text,
          'imageUrl': selectedImageUrl,
        });
        context.go('/navigator/home');
      }
    } else {
      // Show validation error
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
                AuthTextField(
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
