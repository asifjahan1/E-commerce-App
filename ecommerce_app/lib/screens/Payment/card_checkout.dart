import 'package:ecommerce_app/screens/Payment/Features/Stripe/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';

class CardCheckout extends StatefulWidget {
  final double totalAmount; // Total amount from PaymentMethodScreen
  const CardCheckout({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<CardCheckout> createState() => _CardCheckoutState();
}

class _CardCheckoutState extends State<CardCheckout> {
  final PaymentController _paymentController = PaymentController();

  @override
  void initState() {
    super.initState();
    _paymentController.setAmount(widget.totalAmount);
  }

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
                child: ElevatedButton(
                  onPressed: () {
                    // Perform payment logic using _paymentController
                    _paymentController.processPayment().then((success) {
                      if (success) {
                        // Payment successful, navigate to success screen or perform further actions
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment Successful')),
                        );
                        // Navigate to success screen or back to home
                      } else {
                        // Payment failed, show error message or retry option
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Payment Failed. Please try again.')),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
