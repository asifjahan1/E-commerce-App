// ignore_for_file: library_private_types_in_public_api

import 'package:ecommerce_app/screens/Payment/Features/BKash/Bkash%20Checkout/bkash_checkout.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Payment/card_checkout.dart';
import 'package:ecommerce_app/screens/Payment/cod_checkout.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double totalAmount;
  const PaymentMethodScreen({super.key, required this.totalAmount});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selectedMethod;

  void _selectMethod(String method) {
    setState(() {
      _selectedMethod = method;
    });

    print("Selected method: $method");

    // Navigate to the respective checkout page
    switch (method) {
      case 'bkash':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BkashCheckout(totalAmount: widget.totalAmount),
          ),
        );
        break;
      case 'card':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardCheckout(totalAmount: widget.totalAmount),
          ),
        );
        break;
      case 'cod':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodCheckout(totalAmount: widget.totalAmount),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
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
                    "Payment Methods",
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _selectMethod('bkash');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kprimaryColor, width: 2),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kprimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: _selectedMethod == 'bkash'
                                ? const Icon(Icons.check,
                                    color: kprimaryColor, size: 18)
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Pay with Bkash",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: kprimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      height: 40,
                                      child: Image.asset(
                                        'images/bkash.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        _selectMethod('card');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kprimaryColor, width: 2),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kprimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: _selectedMethod == 'card'
                                ? const Icon(Icons.check,
                                    color: kprimaryColor, size: 18)
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Pay with Card",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: kprimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'images/mastercard.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        'images/visa.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset(
                                        'images/amex.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        _selectMethod('cod');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kprimaryColor, width: 2),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: kprimaryColor, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: _selectedMethod == 'cod'
                                ? const Icon(Icons.check,
                                    color: kprimaryColor, size: 18)
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Cash on Delivery",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: kprimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      height: 40,
                                      child: Image.asset(
                                        'images/cod.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
