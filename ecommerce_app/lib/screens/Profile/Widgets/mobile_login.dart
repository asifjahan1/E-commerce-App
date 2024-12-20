import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/mobile_forgot_password.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StateMachineController? controller;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isValidInput = false;

  // Rive animation state machine inputs
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

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

      if (isChecking != null) {
        isChecking?.change(!_isValidInput);
      }
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

      if (trigSuccess != null) trigSuccess?.change(true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(initialIndex: 4),
        ),
      );
    } else {
      if (trigFail != null) trigFail?.change(true);
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
      backgroundColor: const Color.fromARGB(255, 209, 230, 241),
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
      body: SingleChildScrollView(
        child: Responsive(
          mobile: _buildMobileView(),
          tablet: _buildTabletView(),
          desktop: _buildDesktopView(),
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildRiveAnimation(),
            const SizedBox(height: 10),
            _buildPhoneNumberField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 2),
            _buildForgotPasswordButton(),
            const SizedBox(height: 20),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          children: [
            _buildRiveAnimation(),
            const SizedBox(height: 20),
            _buildPhoneNumberField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 2),
            _buildForgotPasswordButton(),
            const SizedBox(height: 30),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
        child: Column(
          children: [
            _buildRiveAnimation(),
            const SizedBox(height: 30),
            _buildPhoneNumberField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 5),
            _buildForgotPasswordButton(),
            const SizedBox(height: 40),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRiveAnimation() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: RiveAnimation.asset(
        "images/animated_login_character.riv",
        stateMachines: const ["Login Machine"],
        onInit: (artboard) {
          controller = StateMachineController.fromArtboard(artboard, "Login Machine");
          if (controller == null) return;

          artboard.addController(controller!);
          isChecking = controller?.findInput("isChecking");
          isHandsUp = controller?.findInput("isHandsUp");
          trigSuccess = controller?.findInput("trigSuccess");
          trigFail = controller?.findInput("trigFail");
        },
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return TextField(
      onTap: () {
        if (isHandsUp != null) {
          isHandsUp!.change(false);
        }
      },
      onChanged: (value) {
        if (isHandsUp != null) {
          isHandsUp!.change(false);
        }
        if (isChecking == null) return;

        isChecking!.change(true);
      },
      keyboardType: TextInputType.emailAddress,
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
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      onTap: () {
        if (isHandsUp != null) {
          isHandsUp!.change(true);
        }
      },
      onChanged: (value) {
        if (isChecking != null) {
          isChecking!.change(false);
        }
        if (isHandsUp == null) return;

        isHandsUp!.change(true);
      },
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
    );
  }

  Widget _buildForgotPasswordButton() {
    return Row(
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
    );
  }

  Widget _buildLoginButton() {
    return MaterialButton(
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
