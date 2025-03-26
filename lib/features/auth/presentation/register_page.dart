import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart'
    as auth_provider;
import 'package:equitycircle/core/widgets/custom_button.dart' show CustomButton;
import 'package:equitycircle/core/widgets/custom_snackbar.dart'
    show showTopSnackbar;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  late bool termsConditionsAccepted;
  bool isLoading = false;
  bool _isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    termsConditionsAccepted = false;
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!termsConditionsAccepted) {
      showTopSnackbar(context, "Please accept the terms and conditions", false);
      return;
    }

    setState(() => isLoading = true);

    try {
      final authProvider = Provider.of<auth_provider.AuthProvider>(
        context,
        listen: false,
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );

      bool success = await authProvider.register(
        userCredential.user!.uid,
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
        passwordController.text,
      );

      if (success) {
        context.go('/');
      } else {
        showTopSnackbar(context, "Registration failed!", false);
      }
    } catch (e) {
      showTopSnackbar(context, "'Error: ${e.toString()}", false);
    }

    setState(() => isLoading = false);
  }

  Future<void> _handleGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    User? user = userCredential.user;

    if (user != null) {
      String? googleIdToken = googleAuth.idToken;

      // Send this to your Laravel backend
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
        context.go('/feeds');
      } else {
        showTopSnackbar(context, "Login failed!", false);
      }
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
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
                    controller: nameController,
                    validator: _validateName,
                    hint: 'Full Name',
                  ),
                  10.heightBox,
                  CustomTextField(
                    controller: emailController,
                    validator: _validateEmail,
                    hint: 'Email Address',
                  ),
                  10.heightBox,
                  CustomTextField(
                    isObscure: !_isPasswordVisible,
                    controller: passwordController,
                    validator: _validatePassword,
                    hint: 'Password',
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

                  10.heightBox,
                  Row(
                    children: [
                      Checkbox(
                        value: termsConditionsAccepted,
                        onChanged: (value) {
                          setState(() {
                            termsConditionsAccepted = value!;
                          });
                        },
                      ),
                      const Text('I Accept Terms And Conditions'),
                    ],
                  ),
                  40.heightBox,
                  CustomButton(
                    text: "Sign up",
                    onTap: _handleRegister,
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
                  10.heightBox,
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
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: AppFonts.inter,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/login');
                        },
                        child: Text(
                          'Login',
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
