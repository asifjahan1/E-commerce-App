import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/settings.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';

class Profile extends StatefulWidget {
  final String? email;
  const Profile({super.key, this.email});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _user;
  String? _registeredEmail;
  String? _registeredPhoneNumber;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadRegisteredInfo();
  }

  // Load current Firebase user
  Future<void> _loadUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  // Store email in SharedPreferences
  Future<void> _storeEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredEmail', email);
    if (kDebugMode) {
      print('Stored Email: $email');
    }
  }

  // Store phone number in SharedPreferences
  Future<void> _storePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredPhoneNumber', phoneNumber);
    if (kDebugMode) {
      print('Stored Phone Number: $phoneNumber');
    }
  }

  // Load email and phone number from SharedPreferences
  Future<void> _loadRegisteredInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _registeredEmail = prefs.getString('registeredEmail');
      _registeredPhoneNumber = prefs.getString('registeredPhoneNumber');
      if (kDebugMode) {
        print('Loaded Email: $_registeredEmail');
        print('Loaded Phone Number: $_registeredPhoneNumber');
      }
    });
  }

  // Logout function to clear SharedPreferences and Firebase sign out
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all shared preferences
    setState(() {
      _registeredEmail = null;
      _registeredPhoneNumber = null;
    });
    FirebaseAuth.instance.signOut(); // Sign out from Firebase
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
              // Profile header section with icon and email/phone display
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
                          (_registeredEmail != null || widget.email != null)
                              ? Icons.add
                              : _registeredPhoneNumber != null
                                  ? Icons.person
                                  : Icons.email,
                          size: 30,
                          color: kprimaryColor,
                        ),
                        const SizedBox(width: 3),
                        widget.email != null
                            ? Text(
                                widget.email!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kprimaryColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : _registeredEmail != null
                                ? Text(
                                    _registeredEmail!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: kprimaryColor,
                                    ),
                                  )
                                : _registeredPhoneNumber != null
                                    ? Text(
                                        _registeredPhoneNumber!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: kprimaryColor,
                                        ),
                                      )
                                    : _user != null
                                        ? Text(
                                            _user!.email ?? '',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: kprimaryColor,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          )
                                        : const Text(
                                            "No user signed in",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: kprimaryColor,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                      ],
                    ),

                    // Settings Icon Button
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(
                              onLogout: _logout,
                              isLoggedIn: _registeredEmail != null ||
                                  _registeredPhoneNumber != null ||
                                  _user != null,
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
              // If no email or phone is registered, show Login/Signup button
              if (_registeredEmail == null &&
                  _registeredPhoneNumber == null &&
                  _user == null)
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
