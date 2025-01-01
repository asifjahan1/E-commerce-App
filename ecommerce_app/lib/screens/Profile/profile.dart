// ignore_for_file: use_build_context_synchronously

import 'dart:async'; // For Timer
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/settings.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:ecommerce_app/responsive.dart'; // Import responsive logic

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
              style: TextStyle(
                color: Colors.black87,
                fontSize: Responsive.isDesktop(context) ? 14 : 12,
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
          child: Padding(
            padding: EdgeInsets.all(
              Responsive.isDesktop(context) ? 40 : 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileCard(context),
                const SizedBox(height: 20),
                if (_registeredEmail == null &&
                    _registeredPhoneNumber == null &&
                    _user == null)
                  _buildLoginButton(context),
                const SizedBox(height: 20),
                if (_user != null || _registeredEmail != null)
                  _buildOrdersSection(),
                const SizedBox(height: 20),
                if (_user != null || _registeredEmail != null)
                  _buildAdditionalInfoSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        Responsive.isDesktop(context) ? 20 : 15,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Responsive.isDesktop(context) ? 35 : 25,
            backgroundColor: kprimaryColor.withOpacity(0.1),
            child: Icon(
              Icons.person,
              size: Responsive.isDesktop(context) ? 40 : 30,
              color: kprimaryColor,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
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
              child: Text(
                widget.email ??
                    _registeredEmail ??
                    _registeredPhoneNumber ??
                    _user?.email ??
                    "No user signed in",
                style: TextStyle(
                  fontSize: Responsive.isDesktop(context) ? 16 : 14,
                  color: kprimaryColor,
                  fontStyle: FontStyle.italic,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ),
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
            icon: Icon(
              Icons.settings,
              size: Responsive.isDesktop(context) ? 35 : 30,
              color: kprimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: MaterialButton(
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
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isTablet(context) ? 30 : 20,
          vertical: 15,
        ),
        child: Text(
          "Login / SignUp",
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isDesktop(context) ? 18 : 16,
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

  // Orders Section
  Widget _buildOrdersSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Orders",
                style: TextStyle(
                  fontSize: Responsive.isDesktop(context) ? 18 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to Orders screen
                  },
                  child: const Text(
                    "View All Orders",
                    style: TextStyle(color: kprimaryColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Use Wrap instead of Row to handle overflow
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildOrderStatusButton("To Pay"),
              _buildOrderStatusButton("To Ship"),
              _buildOrderStatusButton("To Receive"),
              _buildOrderStatusButton("To Review"),
              _buildOrderStatusButton("Return & Cancellations"),
            ],
          ),
        ],
      ),
    );
  }

  // Order Status Button
  Widget _buildOrderStatusButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Handle navigation or functionality
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        backgroundColor: kprimaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(label),
    );
  }

  // Additional Info Section (Reviews, Payment, Contact)
  Widget _buildAdditionalInfoSection() {
    return Column(
      children: [
        _buildInfoBox("My Reviews"),
        const SizedBox(height: 10),
        _buildInfoBox("Payment Options"),
        const SizedBox(height: 10),
        _buildInfoBox("Contact Customer Care"),
      ],
    );
  }

  // Info Box Widget
  Widget _buildInfoBox(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: Responsive.isDesktop(context) ? 16 : 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
