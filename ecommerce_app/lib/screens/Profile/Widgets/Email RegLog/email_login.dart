import 'package:ecommerce_app/screens/Profile/Widgets/Email%20RegLog/google_login_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({super.key});

  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              isLoading = false; // Hide loading indicator
            });
            // Check if the URL contains a specific redirect URI
            if (url.startsWith('https://yourapp.com/auth/callback') ||
                url.startsWith('https://localhost')) {
              _loginSuccess();
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://accounts.google.com/signin'));
  }

  void _loginSuccess() {
    // Navigate to the 4th index of the BottomNavBar on successful login
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(initialIndex: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with Email"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: Colors.white.withOpacity(0.8),
            size: 35,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
          // Add the Google Login Button
          const Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GoogleLoginButton(),
          ),
        ],
      ),
    );
  }
}
