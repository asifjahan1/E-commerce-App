// ignore_for_file: unused_element

import 'dart:convert';
import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Payment/payment_method_screen.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrencyConverter {
  final String apiKey = 'c5873e1ed7251f265b15f0b0';
  final String baseUrl =
      'https://v6.exchangerate-api.com/v6/c5873e1ed7251f265b15f0b0/latest/';

  Future<double> getRate(String currency) async {
    final response = await http.get(Uri.parse('$baseUrl$currency'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['conversion_rates'][currency];
    } else {
      throw Exception('Failed to load conversion rate');
    }
  }

  Future<double> getUserConversionRate() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String country = await _getCountryFromLocation(position);

    if (country == 'UAE') {
      return await getRate('AED');
    } else if (country == 'Bangladesh') {
      return await getRate('BDT');
    } else {
      throw Exception('Unsupported location');
    }
  }

  Future<String> _getCountryFromLocation(Position position) async {
    String country = '';
    final url =
        'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${position.latitude}&longitude=${position.longitude}&localityLanguage=en';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      country = data['countryName'];
    } else {
      throw Exception('Failed to get country from location');
    }

    return country;
  }
}

class CheckOutBox extends StatefulWidget {
  const CheckOutBox({super.key});

  @override
  State<CheckOutBox> createState() => _CheckOutBoxState();
}

class _CheckOutBoxState extends State<CheckOutBox> {
  final TextEditingController _discountController = TextEditingController();
  double _discountPercentage = 0.0;
  String _appliedCode = '';
  final CurrencyConverter currencyConverter = CurrencyConverter();
  double _conversionRate = 0.0;
  bool _isLoading = true;

  // Discount codes and percentages
  final Map<String, double> discountCodes = {
    'ASIF275': 0.25,
    'SAVE10': 0.10,
    'DISCOUNT50': 0.50,
    'NUSRAT25': 0.25,
    'NASRIN50': 0.50,
    'TUTUL25': 0.50,
    'FLAT99': 0.999,
  };

  // discount code
  void _applyDiscount() {
    final code = _discountController.text;
    if (discountCodes.containsKey(code)) {
      setState(() {
        _discountPercentage = discountCodes[code]!;
        _appliedCode = code;
      });
    } else {
      setState(() {
        _discountPercentage = 0.0;
        _appliedCode = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            'Invalid discount code',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  Future<bool> _isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registeredPhoneNumber = prefs.getString('registeredPhoneNumber');
    String? registeredEmail = prefs.getString('registeredEmail');
    // Google/Apple login
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    return (registeredPhoneNumber != null &&
            registeredPhoneNumber.isNotEmpty) ||
        (registeredEmail != null && registeredEmail.isNotEmpty) ||
        firebaseUser != null;
  }

  Future<void> _fetchConversionRate() async {
    try {
      _conversionRate = await currencyConverter.getRate('USD');
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching conversion rate: $e");
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _handleCheckout() async {
    bool isLoggedIn = await _isUserLoggedIn();

    if (isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PaymentMethodScreen(totalAmount: _getTotalAmount()),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterMobile(),
        ),
      );
    }
  }

  double _getTotalAmount() {
    final provider = CartProvider.of(context);
    final totalPrice = provider.totalPrice();
    final discountedAmount = totalPrice * _discountPercentage;
    final discountedPrice = totalPrice - discountedAmount;
    return _appliedCode.isNotEmpty ? discountedPrice : totalPrice;
  }

  String _convertCurrency(double amount) {
    if (_isLoading) return "";
    double convertedAmount = amount / _conversionRate;
    return convertedAmount.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    _fetchConversionRate();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Discount code input field
                TextField(
                  controller: _discountController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    filled: true,
                    fillColor: kcontentColor,
                    hintText: "Enter Discount Code",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    suffixIcon: TextButton(
                      onPressed: _applyDiscount,
                      child: const Text(
                        "Apply",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: kprimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Subtotal section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "SubTotal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "BDT ${CartProvider.of(context).totalPrice()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                // Discount display section
                if (_appliedCode.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discounted (${(_discountPercentage * 100).toInt()}%)",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "BDT ${(_getTotalAmount() - CartProvider.of(context).totalPrice()).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ],
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                // Total section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      _appliedCode.isNotEmpty
                          ? "BDT ${_getTotalAmount().toStringAsFixed(2)}" // Show discounted price
                          : "BDT ${CartProvider.of(context).totalPrice().toStringAsFixed(2)}", // Show total price
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Checkout button
                ElevatedButton(
                  onPressed: _handleCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
