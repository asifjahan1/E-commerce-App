// ignore_for_file: unused_element, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  Future<void> _storeEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredEmail', email);
    if (kDebugMode) {
      print('Stored Email: $email');
    }
  }

  Future<void> _storePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredPhoneNumber', phoneNumber);
    if (kDebugMode) {
      print('Stored Phone Number: $phoneNumber');
    }
  }

  Future<void> _loadRegisteredInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _registeredEmail = prefs.getString('registeredEmail');
      _registeredPhoneNumber = prefs.getString('registeredPhoneNumber');
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _registeredEmail = null;
      _registeredPhoneNumber = null;
    });
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(initialIndex: 4),
      ),
      (Route<dynamic> route) => false,
    );
  }

  // refresh action for user profile
  Future<void> _refreshProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    await _loadUser();
    await _loadRegisteredInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        color: kprimaryColor,
        displacement: 40,
        edgeOffset: 0.0,
        strokeWidth: 3,
        child: SafeArea(
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
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: kprimaryColor.withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: kprimaryColor,
                        ),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.email != null
                                ? Text(
                                    widget.email!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: kprimaryColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  )
                                : _registeredEmail != null
                                    ? Text(
                                        _registeredEmail!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: kprimaryColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      )
                                    : _registeredPhoneNumber != null
                                        ? Text(
                                            _registeredPhoneNumber!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: kprimaryColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                        : _user != null
                                            ? Text(
                                                _user!.email ?? '',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: kprimaryColor,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                              )
                                            : const Text(
                                                "No user signed in",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: kprimaryColor,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
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
                // Show "Login / SignUp" button if no user is signed in
                if (_registeredEmail == null &&
                    _registeredPhoneNumber == null &&
                    _user == null)
                  Center(
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            // Navigate to RegisterMobile and wait for the result
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterMobile(),
                              ),
                            );
                            // Once logged in, refresh user data
                            _refreshProducts();
                          },
                          color: kprimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
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
      ),
    );
  }
}
