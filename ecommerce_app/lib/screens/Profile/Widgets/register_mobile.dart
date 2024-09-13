import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/Email%20RegLog/google_login_button.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/mobile_login.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/registration_screen.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';

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
                  const Text(
                    "Commitment is\nOur Excellence",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
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
                            "Or continue with",
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
                        onTap: (() => const GoogleLoginButton()),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
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
                        // onTap: () {},
                        onTap: (() => const GoogleLoginButton()),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
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
                        "Already have account?",
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

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => const GoogleLoginButton()));
                  //   },
                  //   child: const Text(
                  //     "Login with email",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       decoration: TextDecoration.underline,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),
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
