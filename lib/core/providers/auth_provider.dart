import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; // 🔥 Import Biometric Authentication
import 'package:shared_preferences/shared_preferences.dart';

import '../api/auth_api.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _userData; // Store user data
  bool _isBiometricVerified = false; // Track biometric verification
  final LocalAuthentication auth = LocalAuthentication(); // Biometric instance
  bool supportsFaceRecognition = false; // ✅ Track Face Recognition Support
  String? get token => _token;
  Map<String, dynamic>? get userData => _userData;

  // ✅ User is authenticated only if they have a token & passed biometric auth
  bool get isAuthenticated => _token != null;
  //  && _isBiometricVerified;

  AuthProvider() {
    _loadUserData(); // Load token & check biometric
  }

  Future<void> getTokenAndSaveToDatabase() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();

    if (token != null) {
      String firebaseUid =
          FirebaseAuth.instance.currentUser!.uid; // Firebase UID

      // Call Laravel API to save token
      final response = await AuthApi.saveToken(firebaseUid, token);

      if (response['success']) {
        print("FCM Token saved successfully: $token");
      } else {
        print("Error saving FCM token");
      }
      // Save this token to Firestore or your Laravel backend
      print("User FCM Token: $token");
    }
  }

  // ✅ Prompt Biometric Authentication
  /// **🔹 Step 3: Check Biometric & Face Recognition Support**
  Future<void> _checkBiometricSupport() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.face)) {
      supportsFaceRecognition = true;
    }
  }

  /// **🔹 Step 4: Prompt Biometric Authentication**
  Future<bool> promptBiometricAuth() async {
    await _checkBiometricSupport(); // Check if face unlock is available

    bool canAuthenticate =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();
    if (!canAuthenticate) return false;

    try {
      _isBiometricVerified = await auth.authenticate(
        localizedReason: 'Authenticate using Face or Fingerprint',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      notifyListeners();
      return _isBiometricVerified;
    } catch (e) {
      print("Biometric Auth Error: $e");
      return false;
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');

    if (_token != null) {
      bool biometricSuccess = await promptBiometricAuth();
      if (biometricSuccess) {
        await fetchUser(); // Fetch user data after successful biometric
      } else {
        _token = null; // ❌ Reset token if biometric fails
      }
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password, String text) async {
    try {
      final data = await AuthApi.login(email, password);
      _token = data['access_token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _token!);
      await fetchUser();
      notifyListeners();
      return true;
      // bool biometricSuccess = await promptBiometricAuth();
      // if (biometricSuccess) {
      //   await fetchUser();
      //   notifyListeners();
      //   return true;
      // } else {
      //   _token = null; // Reset token if biometric fails
      //   return false;
      // }
    } catch (error) {
      print("Error during login: $error");
      return false;
    }
  }

  Future<bool> register(
    String firebaseUid,
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final data = await AuthApi.register(
        firebaseUid,
        name,
        email,
        password,
        passwordConfirmation,
      );
      _token = data['access_token']; // assuming the API returns a token

      // Optionally, store token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _token!);

      // bool biometricSuccess = await promptBiometricAuth();
      // if (biometricSuccess) {
      //   await fetchUser();
      //   notifyListeners();
      //   return true;
      // } else {
      //   _token = null; // Reset token if biometric fails
      //   return false;
      // }
      await fetchUser();
      notifyListeners();
      return true;
    } catch (error) {
      // Handle login errors
      print("Error during login: $error");
      return false;
    }
  }

  Future<bool> googleLogin(
    String? name,
    String? email,
    String? photo,
    String? idToken,
  ) async {
    try {
      final data = await AuthApi.sendUserDataToBackend(
        name,
        email,
        photo,
        idToken,
      );
      _token = data['access_token']; // assuming the API returns a token

      // Optionally, store token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _token!);

      bool biometricSuccess = await promptBiometricAuth();
      if (biometricSuccess) {
        await fetchUser();
        notifyListeners();
        return true;
      } else {
        _token = null; // Reset token if biometric fails
        return false;
      }
    } catch (error) {
      // Handle errors
      print("Error during sending user data: $error");
      return false;
    }
  }

  Future<void> fetchUser() async {
    try {
      if (_token == null) return;
      await getTokenAndSaveToDatabase();

      final data = await AuthApi.getUserData(
        _token!,
      ); // Call API to get user data
      _userData = data;

      notifyListeners();
    } catch (e) {
      print("Error fetching user: $e");
      logout(); // Logout if fetching fails (invalid token)
    }
  }

  Future<void> logout() async {
    _token = null;
    _userData = null;
    _isBiometricVerified = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');

    notifyListeners();
  }
}
