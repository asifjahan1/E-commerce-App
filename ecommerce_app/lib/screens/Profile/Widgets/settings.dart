import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  ListTile(
                    title: const Text("Account Information"),
                    onTap: () {
                      // Navigate to Account Information screen
                    },
                  ),
                  ListTile(
                    title: const Text("Address Book"),
                    onTap: () {
                      // Navigate to Address Book screen
                    },
                  ),
                  ListTile(
                    title: const Text("Notification Settings"),
                    onTap: () {
                      // Navigate to Notification Settings screen
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
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
                      // Navigate to Country selection screen
                    },
                  ),
                  ListTile(
                    title: const Row(
                      children: [
                        Text("ভাষা - Language"),
                        Spacer(),
                        Text(
                          "English",
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to Language selection screen
                    },
                  ),
                  ListTile(
                    title: const Text("General"),
                    onTap: () {
                      // Navigate to General settings screen
                    },
                  ),
                  ListTile(
                    title: const Text("Policies"),
                    onTap: () {
                      // Navigate to Policies screen
                    },
                  ),
                  ListTile(
                    title: const Text("Help"),
                    onTap: () {
                      // Navigate to Help screen
                    },
                  ),
                ],
              ),
            ),
            if (widget.isLoggedIn)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: MaterialButton(
                    onPressed: () async {
                      // Call the logout function
                      widget.onLogout();

                      // Remove the registered email from SharedPreferences
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove('registeredEmail');

                      // Log out from Google account
                      await GoogleSignIn().signOut();

                      // Navigate back to the Profile page with default state
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              const BottomNavBar(initialIndex: 4),
                        ),
                      );
                    },
                    color: kprimaryColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
