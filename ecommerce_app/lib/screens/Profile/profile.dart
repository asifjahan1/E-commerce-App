import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/settings.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _registeredPhoneNumber;

  @override
  void initState() {
    super.initState();
    _loadRegisteredPhoneNumber();
  }

  Future<void> _loadRegisteredPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _registeredPhoneNumber = prefs.getString('registeredPhoneNumber');
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('registeredPhoneNumber');
    await prefs.remove('password');
    setState(() {
      _registeredPhoneNumber = null;
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Profile()),
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
                    Icon(
                      _registeredPhoneNumber != null ? Icons.person : Icons.add,
                      size: 30,
                    ),
                    Text(
                      _registeredPhoneNumber ?? '',
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(
                              onLogout: _logout,
                              isLoggedIn: _registeredPhoneNumber != null,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.settings, size: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (_registeredPhoneNumber == null)
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
