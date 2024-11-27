import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class CodCheckout extends StatefulWidget {
  final double totalAmount;

  const CodCheckout({super.key, required this.totalAmount});

  @override
  State<CodCheckout> createState() => _CodCheckoutState();
}

class _CodCheckoutState extends State<CodCheckout> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _newAddressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  bool _isEditingAddress = false;
  bool _showNewAddressField = false;

  // This function saves the new address and refreshes the page
  void _saveNewAddress() {
    setState(() {
      _addressController.text = _newAddressController.text;
      _showNewAddressField = false;
      _isEditingAddress = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Address updated successfully")),
    );
  }

  void _confirmOrder() {
    final address = _addressController.text;
    final mobile = _mobileController.text;
    if (address.isEmpty || mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide both address and mobile number."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // Handle order confirmation logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order confirmed for delivery to $address.")),
    );
  }

  @override
  void initState() {
    super.initState();
    // Load initial address for the user if available
    _addressController.text = "123 Main St, City, Country"; // Example address
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Text(
                      "Cash on Delivery",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Total Amount: BDT ${widget.totalAmount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _addressController,
                  enabled: _isEditingAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                  Icons.check,
                        color: kprimaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_isEditingAddress) {
                            _saveNewAddress();
                          } else {
                            _isEditingAddress = true;
                          }
                        });
                      },
                    ),
                    ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showNewAddressField = true;
                    });
                  },
                  child: const Text(
                    "Change current address",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                if (_showNewAddressField)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _newAddressController,
                      decoration: const InputDecoration(
                        labelText: "Enter new address",
                        border: OutlineInputBorder(),
                      ),
                      onEditingComplete: _saveNewAddress,
                    ),
                  ),
                const SizedBox(height: 20),
                const Text(
                  "Mobile Number",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Enter mobile number",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: MaterialButton(
                    color: kprimaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: _confirmOrder,
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
