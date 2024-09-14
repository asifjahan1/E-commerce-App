import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/settings.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _registeredEmail;
  String? _registeredPhoneNumber;
  // bool _isLoggedInWithPhone = false;
  // bool _isLoggedInWithEmail = false;

  @override
  void initState() {
    super.initState();
    _loadRegisteredInfo();
  }

  Future<void> _storeEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredEmail', email);
    print('Stored Email: $email');
  }

  Future<void> _storePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredPhoneNumber', phoneNumber);
    print('Stored Phone Number: $phoneNumber');
  }

  Future<void> _loadRegisteredInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _registeredEmail = prefs.getString('registeredEmail');
      _registeredPhoneNumber = prefs.getString('registeredPhoneNumber');
      if (kDebugMode) {
        print('Loaded Email: $_registeredEmail');
      }
      if (kDebugMode) {
        print('Loaded Phone Number: $_registeredPhoneNumber');
      }
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('registeredEmail');
    await prefs.remove('registeredPhoneNumber');
    await prefs.remove('password');
    await prefs.remove('isLoggedInWithPhone');
    await prefs.remove('isLoggedInWithEmail');
    setState(() {
      _registeredEmail = null;
      _registeredPhoneNumber = null;
      // _isLoggedInWithPhone = false;
      // _isLoggedInWithEmail = false;
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(initialIndex: 4),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _registeredEmail != null
                              ? Icons.email
                              : _registeredPhoneNumber != null
                                  ? Icons.person
                                  : Icons.add,
                          size: 30,
                          color: kprimaryColor,
                        ),
                        const SizedBox(width: 10),
                        _registeredEmail != null
                            ? Text(
                                _registeredEmail!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kprimaryColor,
                                ),
                              )
                            : _registeredPhoneNumber != null
                                ? Text(
                                    _registeredPhoneNumber!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: kprimaryColor,
                                    ),
                                  )
                                : Container(),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(
                              onLogout: _logout,
                              isLoggedIn: _registeredEmail != null ||
                                  _registeredPhoneNumber != null,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                        color: kprimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (_registeredEmail == null && _registeredPhoneNumber == null)
                Center(
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterMobile(),
                            ),
                          );
                        },
                        color: kprimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: const Text(
                          "Login / SignUp",
                          style: TextStyle(color: Colors.white),
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
