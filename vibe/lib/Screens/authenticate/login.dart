import 'package:flutter/material.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Pages/navigation.dart';
// Import Firebase Auth
import 'package:vibe/Screens/authenticate/register.dart';
// import 'package:vibe/Services/auth_service.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late TextEditingController _userEmailController;
  // late TextEditingController _userPasswordController;
  // final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  // final AuthService _authService = AuthService();
  // final _formKey = GlobalKey<FormState>();

  // text field state
  String error = '';
  String email = '';
  String password = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _userEmailController = TextEditingController();
  //   _userPasswordController = TextEditingController();
  // }

  // @override
  // void dispose() {
  //   _userEmailController.dispose();
  //   _userPasswordController.dispose();
  //   super.dispose();
  // }

  // Future<void> _loginWithEmailAndPassword() async {
  //   try {
  //     // final String email = _userEmailController.text.trim();
  //     // final String password = _userPasswordController.text.trim();
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     // Handle successful login, e.g., navigate to home page
  //   } catch (e) {
  //     // Handle login errors, e.g., show error message
  //     print('Login error: $e');
  //   }
  // }

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
            Center(
              child: Text(
                "Login",
                style: AppTypography.textStyle24Bold,
              ),
            ),
            const SizedBox(
              height: ValuesConstants.containerSmallMedium,
            ),
            Text(
              "Email",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius:
            //         BorderRadius.circular(ValuesConstants.radiusLarge),
            //     color: AppColor.surfaceFG,
            //     border: Border.all(color: AppColor.componentBorder),
            //   ),
            //   padding: const EdgeInsets.only(
            //       left: ValuesConstants.paddingTB,
            //       right: ValuesConstants.paddingTB),
            //   child: TextFormField(
            //     // controller: _userEmailController,
            //     style: AppTypography.textStyle14Bold,
            //     enabled: true,
            //     cursorRadius:
            //         const Radius.circular(ValuesConstants.radiusSmall),
            //     cursorColor: AppColor.componentActive,
            //     decoration: InputDecoration(
            //       hintText: "Email",
            //       hintStyle: AppTypography.textStyle14Inactive,
            //       disabledBorder: InputBorder.none,
            //       enabledBorder: InputBorder.none,
            //       // fillColor: AppColor.surfaceFG,
            //       // filled: true,
            //     ),
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Enter an email'; // Error message if the field is empty
            //       }
            //       return null; // Return null for no error
            //     },
            //     onChanged: (value) {
            //       setState(() {
            //         email =
            //             value; // Assuming 'email' is a String variable in your State class
            //       });
            //     },
            //   ),
            // ),
            AuthTextField(hintText: "Email Address", isSecure: false),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            Text(
              "Password",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            AuthTextField(hintText: "Password", isSecure: true),
            TextButton(
              onPressed: (() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
              }),
              child: Text(
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
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigatorPage(),
                    ),
                  );
                },
                // onPressed: () async {
                //   // if (_formKey.currentState!.validate()) {
                //   dynamic result = await _authService.signIn(email, password);
                //   if (result == null) {
                //     setState(() {
                //       error = 'Could not sign in with the credentials';
                //     });
                //     // }
                //   } else {
                //     // Set the user when login is successful
                //     AuthService.setUser(
                //       uid: result.uid, // Assuming result has a uid property
                //       username: result
                //           .username, // Assuming result has a username property
                //       email:
                //           result.email, // Assuming result has an email property
                //       profilePictureUrl: result
                //           .profilePictureUrl, // Assuming result has a profilePictureUrl property
                //     );

                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => NavigatorPage(),
                //       ),
                //     );
                //   }
                // },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColor.primaryButton),
                ),
                child: Text(
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
