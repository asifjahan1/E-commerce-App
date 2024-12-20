// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_stripe/flutter_stripe.dart';

class CardCheckout extends StatefulWidget {
  final double totalAmount;
  const CardCheckout({super.key, required this.totalAmount});

  @override
  _CardCheckoutState createState() => _CardCheckoutState();
}

class _CardCheckoutState extends State<CardCheckout> {
  TextEditingController amountController = TextEditingController();

  bool _isLoading = false;
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    super.initState();
    amountController.text = widget.totalAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Responsive.isDesktop(context) ? 40 : 16.0), // Adjust padding based on platform
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    const Text(
                      "Pay with Card",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Amount display
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isDesktop(context) ? 40 : 16),
                        child: TextField(
                          readOnly: true,
                          controller: amountController,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await makePayment(context);
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          backgroundColor: const Color(0xffff660e),
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isDesktop(context) ? 50 : 30, // Adjust button padding
                            vertical: Responsive.isDesktop(context) ? 20 : 15,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Make Payment',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(BuildContext context) async {
    try {
      final intAmount = (widget.totalAmount * 100).toInt();
      paymentIntent = await createPaymentIntent(intAmount.toString(), 'AED');

      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              googlePay: const PaymentSheetGooglePay(
                testEnv: true,
                currencyCode: 'AED',
                merchantCountryCode: 'UAE',
              ),
              style: ThemeMode.dark,
              merchantDisplayName: 'Asif',
            ),
          )
          .then((value) {});

      await displayPaymentSheet(context);
    } catch (e, s) {
      if (kDebugMode) {
        print('Exception: $e\n$s');
      }
    }
  }

  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text(
                      "Payment Successful!",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        paymentIntent = null;

        // Navigate to Profile screen after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => const BottomNavBar(initialIndex: 4)),
            (route) => false, // Remove all routes from stack
          );
        });
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('Error: $error\n$stackTrace');
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Stripe Exception: $e');
      }
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Payment Failed"),
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await https.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51Pb4xjAPX9zikVxBegXLWkmf83Koxg2yMNskOkBMWabj1sjETtIojtrOKXuwM8d0KmMg2H7BSkQM27LJEya3k44s00yCpHwFt0',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      if (kDebugMode) {
        print('Payment Intent Body: ${response.body.toString()}');
      }
      return jsonDecode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print('Error charging user: ${err.toString()}');
      }
      return null;
    }
  }
}
