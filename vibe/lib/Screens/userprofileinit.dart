import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibe/Components/errordialog.dart';
import 'package:vibe/Pages/navigation.dart';
// import 'package:vibe/Services/auth_service.dart';
// import 'package:vibe/Services/firebase_storage_service.dart'; // Import your Firebase Storage service
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:vibe/models/userModel.dart';
// import 'package:vibe/wrapper.dart';

class UserProfileInit extends StatefulWidget {
  const UserProfileInit({super.key, required this.user});

  final String user;

  @override
  State<UserProfileInit> createState() => _UserProfileInitState();
}

class _UserProfileInitState extends State<UserProfileInit> {
  File? galleryFile;
  final picker = ImagePicker();

  String username = '';
  String imageUrl = '';

  // Function to upload image to Firebase Storage
//   Future<String> uploadImageToFirebase(File imageFile) async {
//     String fileName = widget.user;

//     Reference storageRef =
//         FirebaseStorage.instance.ref().child('profile/$fileName');

//     UploadTask uploadTask = storageRef.putFile(imageFile);

//     TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

//     String imageUrl = await taskSnapshot.ref.getDownloadURL();
//     return imageUrl;
//   }

//   // Function to get image from gallery or camera and upload it to Firebase
//   Future<void> getImageFromFirebase(ImageSource img) async {
//     final pickedFile = await picker.pickImage(source: img);
//     XFile? xfilePick = pickedFile;

//     if (xfilePick != null) {
//       galleryFile = File(pickedFile!.path);
//       String imageUrl = await uploadImageToFirebase(galleryFile!);
//       // Now you can use the imageUrl as needed, such as associating it with the user's profile
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Nothing is selected')),
//       );
//     }

//     setState(() {
//       // Update UI if needed
//     });
//   }

//   Future showOptions() async {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         actions: [
//           CupertinoActionSheetAction(
//             child: Text('Photo Gallery'),
//             onPressed: () {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from gallery
//               getImage(ImageSource.gallery);
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: Text('Camera'),
//             onPressed: () {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from camera
//               getImage(ImageSource.camera);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future getImage(
//     ImageSource img,
//   ) async {
//     final pickedFile = await picker.pickImage(source: img);
//     XFile? xfilePick = pickedFile;
//     setState(
//       () {
//         if (xfilePick != null) {
//           galleryFile = File(pickedFile!.path);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
//               const SnackBar(content: Text('Nothing is selected')));
//         }
//       },
//     );
//   }
// // }

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
              style: AppTypography.textStyle24Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingLR,
            ),
            GestureDetector(
              onTap: () {
                // showOptions();
              },
              child: galleryFile == null
                  ? Container(
                      height: ValuesConstants.containerLarge,
                      width: ValuesConstants.containerLarge,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ValuesConstants.radiusCircle),
                        color:
                            AppColor.surfaceFG, // Add a color for the container
                      ),
                      child: Center(
                          child: Text(
                        "Upload",
                        style: AppTypography.textStyle14Bold,
                      )),
                    )
                  : Container(
                      height: ValuesConstants.containerLarge,
                      width: ValuesConstants.containerLarge,
                      decoration: BoxDecoration(
                        // borderRadius:
                        //     BorderRadius.circular(ValuesConstants.radiusCircle),
                        color:
                            AppColor.surfaceFG, // Add a color for the container
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                            File(galleryFile!.path),
                          ),
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
                  child: TextFormField(
                    // controller: _userConfirmPassController,
                    style: AppTypography.textStyle14Bold,
                    enabled: true,
                    cursorRadius:
                        const Radius.circular(ValuesConstants.radiusSmall),
                    cursorColor: AppColor.componentActive,
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: AppTypography.textStyle14Inactive,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      // fillColor: AppColor.surfaceFG,
                      // filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a username'; // Error message if the field is empty
                      }
                      return null; // Return null for no error
                    },
                    onChanged: (value) {
                      setState(() {
                        username =
                            value; // Assuming 'email' is a String variable in your State class
                      });
                    },
                  ),
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
                onPressed: () async {
                  // widget.user = UserModel(
                  //     uid: widget.user.uid,
                  //     email: widget.user.email,
                  //     username: username,
                  //     profilePictureUrl: imageUrl);

                  // AuthService.setUser(
                  //   uid: widget.user.uid, // Assuming result has a uid property
                  //   username: widget.user
                  //       .username, // Assuming result has a username property
                  //   email: widget
                  //       .user.email, // Assuming result has an email property
                  //   profilePictureUrl: widget.user
                  //       .profilePictureUrl, // Assuming result has a profilePictureUrl property
                  // );
                  // try {
                  //   uploadImageToFirebase(galleryFile!);
                  // } catch (Exception) {
                  //   // ErrorDialogBox(
                  //   //   title: "Please select an image",
                  //   //   description: "Please upload an image to continue",
                  //   // );
                  // }
                  if (galleryFile == null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ErrorDialogBox(
                            title: "Please select an image",
                            description: "Please upload an image to continue",
                          );
                        });
                  } else if (username == '') {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ErrorDialogBox(
                            title: "Enter your username",
                            description: "Please your username to continue",
                          );
                        });
                  } else {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const NavigatorPage(),
                    //   ),
                    // );
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColor.primaryButton),
                ),
                child: Text(
                  'Continue',
                  style: AppTypography.textStyle14Bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
