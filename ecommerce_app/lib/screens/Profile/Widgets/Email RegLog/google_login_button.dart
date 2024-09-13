import 'package:ecommerce_app/screens/Profile/Widgets/Email%20RegLog/google_signin_service.dart';
import 'package:flutter/material.dart';

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({super.key});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => GoogleSignInService().signInWithGoogle(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      child: const Text("Login with Google"),
    );
  }
}
