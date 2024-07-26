// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/mobile_forgot_password.dart';
// import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registeredPhoneNumber = prefs.getString('registeredPhoneNumber');
    String? storedPassword = prefs.getString('password');

    if (registeredPhoneNumber == _phoneNumberController.text &&
        storedPassword == _passwordController.text) {
      // Save login state for 30 days
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loginTime', DateTime.now().toIso8601String());

      // Navigate to Profile screen with updated BottomNavBar index
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(initialIndex: 4),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number or password')),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcontentColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RegisterMobile(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black.withOpacity(0.8),
            size: 30,
          ),
        ),
        title: const Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.green,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [
          SizedBox(),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: kcontentColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  hintText: "Enter your mobile number",
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
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Enter your password",
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
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: _login,
                color: kprimaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
        ),
      ),
    );
  }
}
