// ignore_for_file: use_build_context_synchronously

// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Payment/payment_method_screen.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/Email%20RegLog/apple_sign_in.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/mobile_login.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/registration_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'Email RegLog/Animate Text/liquid_text.dart';

class RegisterMobile extends StatefulWidget {
  const RegisterMobile({super.key});

  @override
  State<RegisterMobile> createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
  final TextEditingController _phoneNumberController = TextEditingController();

  void _checkPhoneNumber() {
    String phoneNumber = _phoneNumberController.text;

    // Replace this with your own logic to check if the phone number is already registered
    bool isPhoneNumberRegistered = _isPhoneNumberRegistered(phoneNumber);

    if (isPhoneNumberRegistered) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RegistrationScreen(phoneNumber: phoneNumber),
        ),
      );
    }
  }

  bool _isPhoneNumberRegistered(String phoneNumber) {
    // Implement your logic to check if the phone number is registered
    // For now, let's assume it returns false
    return false;
  }

  Future<void> _loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Ensure the user is signed out before prompting account selection
      await googleSignIn.signOut();

      // Now prompt the user to select a Google account
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in process
        if (kDebugMode) {
          print('User canceled the login process');
        }
        return;
      }

      // Obtain the authentication details from the selected Google account
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the GoogleAuthProvider
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the sign-in was successful
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Navigate to PaymentMethodScreen after successful sign-in
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                PaymentMethodScreen(totalAmount: _getTotalAmount()),
          ),
        );
      }
    } catch (e) {
      // Handle sign-in errors
      if (kDebugMode) {
        print('Google sign-in failed: $e');
      }
    }
  }

  double _getTotalAmount() {
    // Implement your logic to get the total amount here
    return 100.0; // Replace with actual total amount
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: kprimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    // Navigate to Profile screen using BottomNavBar index update
                    BottomNavBar.of(context)?.updateIndex(4);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white.withOpacity(0.8),
                    size: 35,
                  ),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'images/Noor Al-Sana.jpg',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const LiquidText(
                    text: 'COMMITMENT IS\nOUR EXCELLENCE',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // TextLiquidFill(
                  //   text: 'COMMITMENT IS\nOUR EXCELLENCE',
                  //   waveColor: Colors.blueAccent, // Color of the wave animation
                  //   boxBackgroundColor:
                  //       kprimaryColor, // Use the same background color as your screen
                  //   textStyle: const TextStyle(
                  //     color: Colors.white, // Text color when filled
                  //     fontSize: 20.0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   boxHeight: 58, // Height of the text box
                  //   waveDuration: const Duration(
                  //       seconds: 2), // Duration of the wave effect
                  //   textAlign: TextAlign.center, // Align the text to the center
                  // ),

                  const SizedBox(height: 40),
                  const Text(
                    "Register or Login with Mobile Number",
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'images/bangladesh.png',
                            width: 28,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Text(
                          '+880',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                              hintText: "Enter your mobile number",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                            onTap: _checkPhoneNumber,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.white30,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or Login with",
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.white30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Google and Apple Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _loginWithGoogle,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset("images/google.png"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          AuthMethods().signInWithApple(
                            scopes: [
                              AppleIDAuthorizationScopes.email,
                              AppleIDAuthorizationScopes.fullName
                            ],
                          ).then((user) {
                            if (user != null) {
                              // Navigate to PaymentMethodScreen after successful sign-in
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => PaymentMethodScreen(
                                      totalAmount: _getTotalAmount()),
                                ),
                              );
                            }
                          }).catchError((e) {
                            if (kDebugMode) {
                              print('Apple sign-in failed: $e');
                            }
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset("images/apple.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 17,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to Login screen
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
