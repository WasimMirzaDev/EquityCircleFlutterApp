import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart'
    as auth_provider;
import 'package:equitycircle/core/widgets/custom_button.dart';
import 'package:equitycircle/core/widgets/custom_textfield.dart'
    show CustomTextField;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../../../core/constants/appColors.dart' show AppColors;
import '../../../core/constants/appFonts.dart';
import '../../../core/widgets/custom_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    if (savedEmail != null && savedPassword != null) {
      setState(() {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
      });
    }
  }

  // Function to save credentials
  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailController.text.trim());
    prefs.setString('password', passwordController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => isLoading = true);

    try {
      final authProvider = Provider.of<auth_provider.AuthProvider>(
        context,
        listen: false,
      );
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(
      //       email: emailController!.text.trim(),
      //       password: passwordController!.text,
      //     );
      // String firebaseUid = userCredential.user!.uid;
      bool success = await authProvider.login(
        // firebaseUid,
        emailController.text.trim(),
        passwordController.text,
      );

      if (success) {
        await _saveCredentials();
        showTopSnackbar(context, "Login Successfully!", true);
        context.go('/');
      } else {
        showTopSnackbar(context, "Login failed!", false);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed!";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      }
      showTopSnackbar(context, errorMessage, false);
    } catch (e) {
      showTopSnackbar(context, "An unexpected error occurred.", false);
    }

    setState(() => isLoading = false);
  }

  Future<void> _handleGoogleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Ensure previous account is signed out to always show account selection
    await googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      showTopSnackbar(context, "Google Sign-In canceled", false);

      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      String? googleIdToken = googleAuth.idToken;

      final authProvider = Provider.of<auth_provider.AuthProvider>(
        context,
        listen: false,
      );

      bool success = await authProvider.googleLogin(
        user.displayName,
        user.email,
        user.photoURL,
        googleIdToken,
      );

      if (success) {
        context.go('/');
      } else {
        showTopSnackbar(context, "Login failed!", false);
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icon/Equity_Circle_icon.png",
                        height: 30.h,
                        width: 30.w,
                      ),
                      8.widthBox,
                      Text(
                        'Equity Circle',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  20.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'Welcome to Equity Circle, a platform to connect with the social world',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: AppFonts.inter,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  30.heightBox,
                  CustomTextField(
                    controller: emailController,
                    validator: _validateEmail,
                    hint: "Email Address",
                  ),

                  10.heightBox,
                  CustomTextField(
                    isObscure: !_isPasswordVisible,
                    controller: passwordController,
                    validator: _validatePassword,
                    hint: "Password",
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,

                          color:
                              _isPasswordVisible
                                  ? AppColors.purpleColor
                                  : AppColors.greyColor,
                        ),
                      ),
                    ),
                  ),

                  40.heightBox,
                  CustomButton(
                    text: "Sign in",
                    onTap: _handleLogin,
                    loading: isLoading,
                  ),

                  20.heightBox,
                  Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: AppFonts.inter,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  20.heightBox,
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      _handleGoogleSignIn();
                    },
                    icon: const Icon(Icons.login, color: AppColors.purpleColor),
                    label: const Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  10.heightBox,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purpleColor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Login with Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/register');
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            fontFamily: AppFonts.inter,
                            fontWeight: FontWeight.w400,
                            color: AppColors.purpleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
