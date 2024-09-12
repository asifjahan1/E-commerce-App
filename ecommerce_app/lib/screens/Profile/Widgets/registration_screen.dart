// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/mobile_login.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/mobile_forgot_password.dart';

class RegistrationScreen extends StatefulWidget {
  final String phoneNumber;
  const RegistrationScreen({super.key, required this.phoneNumber});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _verificationId;
  bool _isLoading = false; // Add a flag for loading state

  bool _isPhoneNumberRegistered(String phoneNumber) {
    // Replace with your logic to check if the phone number is registered
    // For now, let's assume it's not registered
    return false;
  }

  void _sendCode() async {
    String phoneNumber = _phoneNumberController.text;

    if (_isPhoneNumberRegistered(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This phone number is already registered'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });
        if (kDebugMode) {
          print('Failed to verify phone number');
          // print('Failed to verify phone number: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
          _isLoading = false;
        });
      },
    );
  }

  void _verifyCode() async {
    String code = _codeController.text;
    String password = _passwordController.text;

    if (_verificationId != null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      try {
        await FirebaseAuth.instance.signInWithCredential(credential);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'registeredPhoneNumber',
          _phoneNumberController.text,
        );
        await prefs.setString('password', password); // Save password

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mobile Number Confirmed')),
        );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } catch (e) {
        if (kDebugMode) {
          print("Invalid code");
        }
      }
    }
  }

  void _resetPassword() async {
    // Navigate to ForgotPassword screen
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPassword(),
      ),
    );
  }

  void _navigateToLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        leading: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black.withOpacity(0.8),
              size: 30,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    hintText: "Enter Mobile Number",
                    helperText: "e.g: +8801234567890",
                    helperStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kprimaryColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: _isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: LoadingAnimationWidget.inkDrop(
                              color: kprimaryColor,
                              size: 40,
                            ),
                          )
                        : TextButton(
                            onPressed: _sendCode,
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                color: kprimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    hintText: "Enter the Received Code",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kprimaryColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Make a Password",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kprimaryColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _resetPassword,
                      child: const Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: kprimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  onPressed: _verifyCode,
                  color: kprimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _navigateToLoginScreen,
                  child: const Text(
                    "Already have Account? Login",
                    style: TextStyle(
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
