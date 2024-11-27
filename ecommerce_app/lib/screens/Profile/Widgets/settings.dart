import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:ecommerce_app/responsive.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onLogout;
  final bool isLoggedIn;

  const SettingsScreen({
    super.key,
    required this.onLogout,
    required this.isLoggedIn,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Responsive(
          mobile: _buildSettingsLayout(context, 8.0, 18.0, 24.0),
          tablet: _buildSettingsLayout(context, 16.0, 20.0, 28.0),
          desktop: _buildSettingsLayout(context, 24.0, 24.0, 30.0),
        ),
      ),
    );
  }

  /// A method to build the layout with different padding, font sizes, and icon sizes.
  Widget _buildSettingsLayout(
      BuildContext context, double padding, double fontSize, double iconSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: iconSize,
                ),
              ),
              Text(
                "Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(padding),
            children: [
              _buildListTile("Account Information", fontSize),
              _buildListTile("Address Book", fontSize),
              _buildListTile("Notification Settings", fontSize),
              _buildCountryTile(padding),
              _buildLanguageTile(fontSize),
              _buildListTile("General", fontSize),
              _buildListTile("Policies", fontSize),
              _buildListTile("Help", fontSize),
            ],
          ),
        ),
        if (widget.isLoggedIn)
          Padding(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: MaterialButton(
                onPressed: _handleLogout,
                color: kprimaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: padding + 4,
                  horizontal: padding * 5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ),
          ),
      ],
    );
  }

  ListTile _buildListTile(String title, double fontSize) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize - 2),
      ),
      onTap: () {
        // Implement navigation logic here
      },
    );
  }

  Widget _buildCountryTile(double paddingValue) {
    return ListTile(
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: paddingValue),
            child: Image.asset(
              'images/bangladesh.png',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Country"),
              Text(
                "Bangladesh",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        // Implement country selection logic
      },
    );
  }

  Widget _buildLanguageTile(double fontSize) {
    return ListTile(
      title: Row(
        children: [
          const Text("ভাষা - Language"),
          const Spacer(),
          Text(
            "English",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
      onTap: () {
        // Implement language selection logic
      },
    );
  }

  Future<void> _handleLogout() async {
    widget.onLogout();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('registeredEmail');
    await prefs.remove('registeredPhoneNumber');
    await GoogleSignIn().signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(initialIndex: 4),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
