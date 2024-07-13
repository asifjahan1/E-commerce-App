import 'dart:convert';

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
  Map<String, dynamic>? paymentIntent;

  // @override
  // void initState() {
  //   // super.initState();
  //   // // Initialize the payment controller with the total amount
  //   // _paymentController.setAmount(widget.totalAmount);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
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
                child: TextButton(
                  onPressed: () async {
                    await makePayment();
                  },
                  child: const Text('Make Payment'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10', 'USD');
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

      await displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  Future<void> displayPaymentSheet() async {
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
                      "Payment Successful",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card', // এখানে পরিবর্তন করা হয়েছে
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
      print('payment Intent Body->> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
      return null;
    }
  }

  String calculateAmount(String amount) {
    final calculateAmount = (int.parse(amount)) * 100;
    return calculateAmount.toString();
  }
}
