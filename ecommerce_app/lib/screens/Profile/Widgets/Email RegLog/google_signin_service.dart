import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        // Store the email in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('registeredEmail', user.email);
        await prefs.setString(
            'registeredPhoneNumber', ''); // Clear phone number if needed

        // Navigate to BottomNavBar at index 4
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(initialIndex: 4),
          ),
        );
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
