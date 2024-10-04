// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/mobile_forgot_password.dart';
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
  bool _isLoading = false;
  bool _isValidInput = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(_validateInput);
    _passwordController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      _isValidInput = _phoneNumberController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _isValidPhoneNumber(_phoneNumberController.text);
    });
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final bangladeshPattern = RegExp(r'^\+880\d{10}$');
    final uaePattern = RegExp(r'^\+971\d{9}$');
    return bangladeshPattern.hasMatch(phoneNumber) ||
        uaePattern.hasMatch(phoneNumber);
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registeredPhoneNumber = prefs.getString('registeredPhoneNumber');
    String? storedPassword = prefs.getString('password');

    if (registeredPhoneNumber == _phoneNumberController.text &&
        storedPassword == _passwordController.text) {
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loginTime', DateTime.now().toIso8601String());

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

    setState(() {
      _isLoading = false;
    });
  }

  void _resetPassword() async {
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
        title: const Text(
          'Login',
          style: TextStyle(
            color: kprimaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: kcontentColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        hintText: "Enter your mobile number",
                        helperText: "e.g: +8801234567890, +97121234567",
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
                            "Forgot Password?",
                            style: TextStyle(
                              color: kprimaryColor,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: _isValidInput && !_isLoading ? _login : null,
                      color: kprimaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
