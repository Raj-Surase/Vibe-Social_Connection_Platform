import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:vibe/Components/customtextfield.dart';
import 'package:vibe/Pages/home.dart';
import 'package:vibe/Pages/navigation.dart';
import 'package:vibe/Screens/register.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _userLoginController;
  late TextEditingController _userPasswordController;
  // final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  @override
  void initState() {
    super.initState();
    _userLoginController = TextEditingController();
    _userPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _userLoginController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loginWithEmailAndPassword() async {
    // try {
    final String email = _userLoginController.text.trim();
    final String password = _userPasswordController.text.trim();
    //   UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   // Handle successful login, e.g., navigate to home page
    // } catch (e) {
    //   // Handle login errors, e.g., show error message
    //   print('Login error: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(ValuesConstants.paddingLR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: ValuesConstants.ratioOneForth(context),
            // ),
            const Center(
              child: Text(
                "Login",
                style: AppTypography.textStyle24Bold,
              ),
            ),
            const SizedBox(
              height: ValuesConstants.containerSmallMedium,
            ),
            const Text(
              "User Name",
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
                  textFieldController: _userLoginController,
                  hintText: "Username"),
            ),
            const SizedBox(
              height: ValuesConstants.paddingTB,
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
                borderRadius:
                    BorderRadius.circular(ValuesConstants.radiusLarge),
                color: AppColor.surfaceFG,
                border: Border.all(color: AppColor.componentBorder),
              ),
              padding: const EdgeInsets.only(
                  left: ValuesConstants.paddingTB,
                  right: ValuesConstants.paddingTB),
              child: CustomTextField(
                  textFieldController: _userPasswordController,
                  hintText: "Password"),
            ),
            TextButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
              }),
              child: const Text(
                "Don't have an account? Sign up.",
                style: AppTypography.textStyle10Link,
              ),
            ),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            SizedBox(
              width: ValuesConstants.screenWidth(context),
              height: ValuesConstants.containerSmallMedium,
              child: TextButton(
                onPressed: (() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                }),
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColor.primaryButton),
                ),
                child: const Text(
                  'Login',
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