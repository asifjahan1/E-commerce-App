import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        // Navigate to BottomNavBar after successful login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(initialIndex: 4),
          ),
        );
      }
    } catch (error) {
      // Handle error here
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
