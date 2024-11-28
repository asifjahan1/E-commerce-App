import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Cart/check_out.dart';
import 'package:ecommerce_app/screens/Detail/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ecommerce_app/Responsive.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _currency = 'BDT';

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _setCurrencyBasedOnLocation(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
  }

  void _setCurrencyBasedOnLocation(double latitude, double longitude) async {
    if (latitude >= 20.0 &&
        latitude <= 27.0 &&
        longitude >= 88.0 &&
        longitude <= 93.0) {
      setState(() {
        _currency = 'BDT';
      });
    } else if (latitude >= 22.0 &&
        latitude <= 26.0 &&
        longitude >= 54.0 &&
        longitude <= 56.0) {
      setState(() {
        _currency = 'AED';
      });
    } else {
      setState(() {
        _currency = 'USD';
      });
    }
  }

  Widget _buildQuantityButton(IconData icon, void Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
        size: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;

    void removeFromCart(int index) {
      setState(() {
        provider.removeProduct(index);
      });
    }

    Widget buildCartItem(BuildContext context, int index) {
      final cartItem = finalList[index];

      String priceText;
      if (_currency == 'BDT') {
        priceText = "BDT ${cartItem.priceBDT.toStringAsFixed(2)}";
      } else if (_currency == 'AED') {
        double priceInAED = cartItem.priceAED;
        priceText = "AED ${priceInAED.toStringAsFixed(2)}";
      } else {
        priceText = "USD ${cartItem.priceBDT.toStringAsFixed(2)}";
      }

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(product: cartItem),
            ),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(Responsive.isTablet(context) ? 20 : 15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(Responsive.isTablet(context) ? 30 : 20),
                child: Row(
                  children: [
                    Hero(
                      tag: 'productImage${cartItem.id}',
                      child: Container(
                        height: 100,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kcontentColor,
                        ),
                        child: Image.asset(cartItem.image),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItem.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.isTablet(context) ? 18 : 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            cartItem.category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.isTablet(context) ? 16 : 14,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            priceText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.isTablet(context) ? 16 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 35,
              right: 35,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => removeFromCart(index),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kcontentColor,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        _buildQuantityButton(
                            Icons.add, () => provider.incrementQtn(index)),
                        const SizedBox(width: 10),
                        Text(
                          cartItem.quantity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildQuantityButton(
                            Icons.remove, () => provider.decrementQtn(index)),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kcontentColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Responsive.isTablet(context) ? 20 : 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: Responsive.isTablet(context) ? 30 : 25),
                  Text(
                    "Cart",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.isTablet(context) ? 30 : 25,
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: finalList.length,
                itemBuilder: (context, index) => buildCartItem(context, index),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Responsive.isTablet(context) ? 30 : 20),
              child: const CheckOutBox(),
            ),
          ],
        ),
      ),
    );
  }
}
