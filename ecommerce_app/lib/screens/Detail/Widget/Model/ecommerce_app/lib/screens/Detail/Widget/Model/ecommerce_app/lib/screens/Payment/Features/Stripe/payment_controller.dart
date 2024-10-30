// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as https;
import 'package:logging/logging.dart';

final log = Logger('PaymentController');

class PaymentController {
  Map<String, dynamic>? paymentIntentData;

  void setAmount(double amount) {}

  Future<bool> processPayment() async {
    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));
    bool paymentSuccessful = true;
    return paymentSuccessful;
  }

  Future<void> makePayment({
    required String amount,
    required String currency,
    required BuildContext context,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency, context);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            customerId: paymentIntentData!['customer'],
            merchantDisplayName: 'Prospects',
            style: ThemeMode.dark,
            googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: 'US',
              testEnv: true,
            ),
            applePay: const PaymentSheetApplePay(
              merchantCountryCode: 'US',
            ),
          ),
        );
        await displayPaymentSheets(context);
      }
    } catch (e, s) {
      log.severe('Exception: $e\nStack trace: $s');
      showMessage(context, 'An error occurred. Please try again.');
    }
  }

  Future<void> displayPaymentSheets(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      log.info('Payment Successful');
      showMessage(context, 'Payment Successful');
    } on StripeException catch (e) {
      log.warning("Error from Stripe: ${e.error.localizedMessage}");
      showMessage(context, "Error from Stripe: ${e.error.localizedMessage}");
    } catch (e) {
      log.severe("Unforeseen error: $e");
      showMessage(context, "An error occurred. Please try again.");
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency, BuildContext context) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await https.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51Pb4xjAPX9zikVxBegXLWkmf83Koxg2yMNskOkBMWabj1sjETtIojtrOKXuwM8d0KmMg2H7BSkQM27LJEya3k44s00yCpHwFt0',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body);
        case 400:
          showMessage(context,
              'Bad Request: The request was unacceptable, often due to missing a required parameter.');
          break;
        case 401:
          showMessage(context, 'Unauthorized: No valid API key provided.');
          break;
        case 402:
          showMessage(context,
              'Request Failed: The parameters were valid but the request failed.');
          break;
        case 403:
          showMessage(context,
              'Forbidden: The API key doesn’t have permissions to perform the request.');
          break;
        case 409:
          showMessage(
              context, 'Conflict: The request conflicts with another request.');
          break;
        case 429:
          showMessage(context,
              'Too Many Requests: Too many requests hit the API too quickly.');
          break;
        case 500:
        case 502:
        case 503:
        case 504:
          showMessage(
              context, 'Server Error: Something went wrong on Stripe’s end.');
          break;
        default:
          showMessage(context, 'An unknown error occurred.');
      }
      return null;
    } catch (err) {
      log.severe('Error charging user: ${err.toString()}');
      showMessage(context,
          'An error occurred while charging the user. Please try again.');
      return null;
    }
  }

  int calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a;
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
