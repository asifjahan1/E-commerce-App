import 'package:ecommerce_app/screens/Profile/Widgets/Email%20RegLog/google_signin_service.dart';
import 'package:flutter/material.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => GoogleSignInService().signInWithGoogle(context),
      child: const Text("Login with Google"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
