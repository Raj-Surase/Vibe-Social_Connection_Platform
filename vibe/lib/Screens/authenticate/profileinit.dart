import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class ProfileInit extends StatefulWidget {
  const ProfileInit({super.key});

  @override
  State<ProfileInit> createState() => _ProfileInitState();
}

class _ProfileInitState extends State<ProfileInit> {
  late TextEditingController usernameController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadProfile() async {
    if (_image == null || usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete your profile')),
      );
      return;
    }

    try {
      // Ensure user is authenticated
      if (_auth.currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not authenticated')),
        );
        return;
      }

      // Upload image to Firebase Storage
      String uid = _auth.currentUser!.uid;
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profile/$uid.jpg');
      UploadTask uploadTask = storageReference.putFile(_image!);

      // Optionally add listeners for task state changes
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Task state: ${snapshot.state}');
        print(
            'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      }, onError: (e) {
        print('Error during upload: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during upload: $e')),
        );
      });

      TaskSnapshot taskSnapshot = await uploadTask;
      String profilePictureUrl = await taskSnapshot.ref.getDownloadURL();

      // Save user data to Firestore
      await _firestore.collection('users').doc(uid).set({
        'username': usernameController.text,
        'profilePicture': profilePictureUrl,
      });

      // Notify profile completion
      context.replace('/navigator/home');
    } catch (e) {
      print('Error uploading profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading profile: $e')),
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
              child: _image == null
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
                          image: FileImage(_image!),
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
                onPressed: _uploadProfile,
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
