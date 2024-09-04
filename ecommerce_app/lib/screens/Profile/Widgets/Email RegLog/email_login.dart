// ignore_for_file: library_private_types_in_public_api

import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({super.key});

  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://accounts.google.com/signin')) {
              String email = request.url
                  .replaceFirst('https://accounts.google.com/signin', '');
              _loginWithEmail(email);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://accounts.google.com/signin'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with Email"),
        leading: IconButton(
          onPressed: () {
            // Navigate to Profile screen using BottomNavBar index update
            BottomNavBar.of(context)?.updateIndex(4);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: Icon(
            Icons.close,
            color: Colors.white.withOpacity(0.8),
            size: 35,
          ),
        ),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }

  Future<void> _loginWithEmail(String email) async {
    // Perform your login logic here, like sending the email to your backend for authentication

    // On success, navigate to the 3rd index of the BottomNavBar
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(initialIndex: 4),
      ),
    );
  }
}
