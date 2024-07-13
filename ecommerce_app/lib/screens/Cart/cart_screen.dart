import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/Detail/details_screen.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/screens/Cart/check_out.dart';
import 'package:ecommerce_app/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Function to build quantity buttons
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
        finalList.removeAt(index);
      });
    }

    Widget buildCartItem(BuildContext context, int index) {
      final cartItem = finalList[index];

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
              padding: const EdgeInsets.all(15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20),
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
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            cartItem.category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "BDT ${cartItem.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
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
      bottomSheet:
          const CheckOutBox(), // Assuming CheckOutBox is a separate widget
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
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>
                              const BottomNavBar(initialIndex: 2),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  const Text(
                    "My Cart",
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: finalList.length,
                itemBuilder: (context, index) => buildCartItem(context, index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
