import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  final String? email;

  const Home({super.key, this.email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  Future<void> _signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homepage")),
      body: Center(
        child: widget.email != null
            ? Text(widget.email!)
            : _user != null
                ? Text("${_user!.email}")
                : const Text("No user signed in"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _signOut,
        child: const Icon(Icons.logout),
      ),
    );
  }
}
