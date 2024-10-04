// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/mobile_login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      String phoneNumber = _phoneNumberController.text;
      String newPassword = _passwordController.text;

      // update password in database or authentication service
      _showSnackbar('Password changed successfully');

      // Navigate back to login screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      _showSnackbar('Please correct the errors');
    }
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // Example validation for phone number using a basic regular expression
    final phoneRegExp =
        RegExp(r'^\+\d{1,3}\d{9,13}$'); // Matches numbers like +8801234567890
    return phoneRegExp.hasMatch(phoneNumber);
  }

  bool _isValidPassword(String password) {
    // Basic password validation: at least 6 characters
    return password.length >= 6;
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            'Reset Password',
            style: TextStyle(
              color: kprimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    hintText: "Enter Mobile Number",
                    helperText: "e.g: +8801234567890",
                    helperStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!_isValidPhoneNumber(value)) {
                      return 'Invalid phone number format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Make a New Password",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    } else if (!_isValidPassword(value)) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  onPressed: _resetPassword,
                  color: kprimaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(fontSize: 16),
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
