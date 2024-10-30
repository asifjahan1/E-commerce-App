// ignore_for_file: use_build_context_synchronously

import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/settings.dart';
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
  OverlayEntry? _overlayEntry;
  Timer? _overlayTimer;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadRegisteredInfo();
  }

  Future<void> _loadUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
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

  void _showEmailOverlay(BuildContext context, String email, Offset position) {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy - 30,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(),
            ),
            child: Text(
              email,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _overlayTimer = Timer(const Duration(milliseconds: 1200), _removeOverlay);
  }

  void _removeOverlay() {
    _overlayTimer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _overlayTimer?.cancel();
    super.dispose();
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
                        child: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            final emailToShow = widget.email ??
                                _registeredEmail ??
                                _registeredPhoneNumber ??
                                _user?.email;

                            if (emailToShow != null && emailToShow.isNotEmpty) {
                              _showEmailOverlay(
                                context,
                                emailToShow,
                                details.globalPosition,
                              );
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.email ??
                                    _registeredEmail ??
                                    _registeredPhoneNumber ??
                                    _user?.email ??
                                    "No user signed in",
                                style: const TextStyle(
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
                if (_registeredEmail == null &&
                    _registeredPhoneNumber == null &&
                    _user == null)
                  Center(
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterMobile(),
                              ),
                            );
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

  Future<void> _refreshProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    await _loadUser();
    await _loadRegisteredInfo();
  }
}
