import 'package:flutter/material.dart';
import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';

class AddToCart extends StatefulWidget {
  final Product product;

  const AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: MaterialButton(
                onPressed: null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.white, width: 2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (currentIndex > 1) {
                          setState(() {
                            currentIndex--;
                          });
                        }
                      },
                      iconSize: 18,
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      currentIndex.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          currentIndex++;
                        });
                      },
                      iconSize: 18,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 55,
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                child: MaterialButton(
                  onPressed: () {
                    final provider = CartProvider.of(context, listen: false);
                    widget.product.quantity = currentIndex;
                    provider.toggleFavorite(widget.product);

                    // Show a snackbar after adding to cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: kprimaryColor,
                        content: Text(
                          "Successfully added!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  color: kprimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
