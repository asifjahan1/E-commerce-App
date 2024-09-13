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

  void _resetPassword() {
    String phoneNumber = _phoneNumberController.text;
    String newPassword = _passwordController.text;

    // Implement your validation logic here, for example, checking if the phone number is valid
    if (_isValidPhoneNumber(phoneNumber) && _isValidPassword(newPassword)) {
      // update password in database or authentication service
      _showSnackbar('Password changed successfully');

      // Proceed to login screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      _showSnackbar('Invalid phone number or password');
    }
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // validation logic
    // For now, just check if it's not empty
    return phoneNumber.isNotEmpty;
  }

  bool _isValidPassword(String password) {
    // validation logic
    // For now, just check if it's not empty
    return password.isNotEmpty;
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kcontentColor,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      color: Colors.grey,
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
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: _resetPassword,
                color: kprimaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: const Text(
                  "Confirm",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
