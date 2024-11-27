import 'package:ecommerce_app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatelessWidget {
  final String bKashURL;
  const PaymentScreen({super.key, required this.bKashURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay with Bkash",
          style: TextStyle(
            fontSize: Responsive.isDesktop(context) ? 30 : 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffEE1284),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(
          Responsive.isDesktop(context) ? 40 : 16.0,
        ),
        child: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(bKashURL)),
        ),
      ),
    );
  }
}
