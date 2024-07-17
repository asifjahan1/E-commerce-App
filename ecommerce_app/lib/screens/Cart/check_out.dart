import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Payment/payment_method_screen.dart';
import 'package:ecommerce_app/screens/Profile/Widgets/register_mobile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutBox extends StatefulWidget {
  const CheckOutBox({Key? key}) : super(key: key);

  @override
  State<CheckOutBox> createState() => _CheckOutBoxState();
}

class _CheckOutBoxState extends State<CheckOutBox> {
  final TextEditingController _discountController = TextEditingController();
  double _discountPercentage = 0.0;
  String _appliedCode = '';

  final Map<String, double> discountCodes = {
    'ASIF275': 0.25,
    'SAVE10': 0.10,
    'DISCOUNT50': 0.50,
    'NUSRAT25': 0.25,
    'NASRIN50': 0.50,
    'TUTUL25': 0.50,
    // add more if needed
  };

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

  void _handleCheckout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registeredPhoneNumber = prefs.getString('registeredPhoneNumber');

    if (registeredPhoneNumber != null && registeredPhoneNumber.isNotEmpty) {
      // User is registered, navigate to PaymentMethodScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PaymentMethodScreen(totalAmount: _getTotalAmount()),
        ),
      );
    } else {
      // User is not registered, navigate to RegisterMobile
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterMobile(),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 300,
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
                      ? "BDT ${_getTotalAmount().toStringAsFixed(2)}"
                      : "BDT ${CartProvider.of(context).totalPrice()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimaryColor,
                  minimumSize: const Size(double.infinity, 55),
                ),
                onPressed: _handleCheckout,
                child: const Text(
                  "Check Out",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
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
