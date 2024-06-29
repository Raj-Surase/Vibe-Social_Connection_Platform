import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Database/firestore_service.dart';
import 'package:vibe/components/custom_snackbar.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class SessionCreateViewModel extends ChangeNotifier {
  late TextEditingController sessionNameController;
  late Future<List<String>> imageUrlsFuture;
  String? selectedImageUrl;
  int? selectedIndex;

  void initialise(BuildContext context) {
    imageUrlsFuture = fetchImageUrls();
    sessionNameController = TextEditingController();
    notifyListeners();
  }

  @override
  void dispose() {
    sessionNameController.dispose();
    super.dispose();
  }

  bool isLoggedIn(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  void redirectToAuthPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).replace(AppRoutes.INITIALROUTE);
    });
  }

  Future<List<String>> fetchImageUrls() async {
    ListResult result =
        await FirebaseStorage.instance.ref('/thumbnail/').listAll();
    List<String> urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));
    return urls;
  }

  void closeDialog(BuildContext context) {
    context.pop();
  }

  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(ValuesConstants.paddingLR),
                  decoration: BoxDecoration(
                    color: AppColor.surfaceFG,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(ValuesConstants.radiusLarge),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
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
                                  color: AppColor.textHighEm,
                                ),
                              );
                            } else {
                              List<String> imageUrls = snapshot.data!;
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: imageUrls.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 16 / 9,
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
                                          ValuesConstants.radiusMedium,
                                        ),
                                        color: selectedIndex == index
                                            ? AppColor.componentInactive
                                                .withOpacity(0.5)
                                            : AppColor.surfaceBG,
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Center(
                                        child: selectedIndex == index
                                            ? Icon(
                                                Icons.check_rounded,
                                                color: AppColor.componentActive,
                                                size: ValuesConstants
                                                    .containerSmall,
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
                              backgroundColor: MaterialStateProperty.all(
                                  AppColor.primaryButton),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {});
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
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void createSession(BuildContext context) async {
    if (sessionNameController.text.isNotEmpty && selectedImageUrl != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          String? userId = user.uid;
          String? userName = user.displayName;
          String? userEmail = user.email;

          void _continue() async {
            if (sessionNameController.text.isNotEmpty &&
                selectedImageUrl != null) {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                FirestoreService firestoreService = FirestoreService();
                await firestoreService.addUser(
                  user.uid,
                  sessionNameController.text,
                  user.email!,
                  selectedImageUrl!,
                  // user.email!,
                  false,
                  false,
                  0,
                  0,
                  [],
                );
                context.go(AppRoutes.QUEUEROUTE);
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill in all fields')),
              );
            }
          }

          // Show success message
          createSnackBar('Session Created');

          // Redirect to home page
          GoRouter.of(context).replace(AppRoutes.QUEUEROUTE);
        } catch (e) {
          createSnackBar('Failed to create session: $e');
        }
      }
    } else {
      createSnackBar('Please fill in all fields');
    }
  }
}
