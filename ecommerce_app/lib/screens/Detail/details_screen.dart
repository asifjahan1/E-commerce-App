import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/Detail/Widget/image_slider.dart';
import 'package:ecommerce_app/screens/Detail/Widget/addto_cart.dart';
import 'package:ecommerce_app/screens/Detail/Widget/description.dart';
import 'package:ecommerce_app/screens/Detail/Widget/detail_app_bar.dart';
import 'package:ecommerce_app/screens/Detail/Widget/items_details.dart';

class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentImage = 0;
  int currentColor = 1; // Assuming initial color selection
  late Timer _timer;
  final PageController _pageController = PageController();
  int cartItemCount = 0; // State variable for cart count
  bool isInCart = false; // State variable for shopping cart icon

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentImage < 4) {
        currentImage++;
        _pageController.animateToPage(
          currentImage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      } else {
        currentImage = 0;
        _pageController.animateToPage(
          currentImage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Function to update cart item count
  void updateCartItemCount(int count) {
    setState(() {
      cartItemCount = count;
      isInCart = count > 0;
    });
  }

  // Function to update selected color
  void updateSelectedColor(int index) {
    setState(() {
      currentColor = index;
    });
  }

  // refresh action
  Future<void> _refreshProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshProducts,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          edgeOffset: 0.0,
          color: kprimaryColor,
          strokeWidth: 3,
          displacement: 40,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return DetailAppBar(
                      product: widget.product,
                      updateCartCount: updateCartItemCount,
                    );
                  },
                ),
                MyImageSlider(
                  image: widget.product.image,
                  onChange: (index) {
                    setState(() {
                      currentImage = index;
                    });
                  },
                  pageController: _pageController,
                ),
                // Existing code...
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 100, // Adjusted for AddToCart button
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemsDetails(product: widget.product),
                        const SizedBox(height: 20),
                        // Color selection
                        const Text(
                          "Color",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: List.generate(
                            widget.product.colors.length,
                            (index) => GestureDetector(
                              onTap: () {
                                updateSelectedColor(index);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 1000),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentColor == index
                                      ? Colors.white
                                      : widget.product.colors[index],
                                  border: currentColor == index
                                      ? Border.all(
                                          color: widget.product.colors[index],
                                        )
                                      : null,
                                ),
                                padding: currentColor == index
                                    ? const EdgeInsets.all(2)
                                    : null,
                                margin: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: widget.product.colors[index],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ... other code
                        const SizedBox(height: 25),
                        Description(description: widget.product.description),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: double.infinity,
          child: AddToCart(
            product: widget.product,
            updateCartCount: updateCartItemCount,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
