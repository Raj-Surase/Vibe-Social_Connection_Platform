import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Database/firestore_service.dart';

class ProfileInitViewModel extends ChangeNotifier {
  late TextEditingController usernameController;
  late Future<List<String>> imageUrlsFuture;
  String? selectedImageUrl;
  int? selectedIndex;

  void initialise() {
    usernameController = TextEditingController();
    imageUrlsFuture = _fetchImageUrls();
    notifyListeners();
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

  void pickImage(BuildContext context) {
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
                      future: imageUrlsFuture,
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
                              MaterialStateProperty.all(AppColor.primaryButton),
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

  void continueRegistration(BuildContext context) async {
    if (usernameController.text.isNotEmpty && selectedImageUrl != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirestoreService firestoreService = FirestoreService();
        await firestoreService.addUser(
          user.uid,
          usernameController.text,
          user.email!,
          selectedImageUrl!,
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
}
