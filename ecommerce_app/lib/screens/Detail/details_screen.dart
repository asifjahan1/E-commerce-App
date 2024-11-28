// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/Detail/Widget/image_slider.dart';
import 'package:ecommerce_app/screens/Detail/Widget/addto_cart.dart';
import 'package:ecommerce_app/screens/Detail/Widget/description.dart';
import 'package:ecommerce_app/screens/Detail/Widget/detail_app_bar.dart';
import 'package:ecommerce_app/screens/Detail/Widget/items_details.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentImage = 0;
  int currentColor = 1;
  late Timer _timer;
  final PageController _pageController = PageController();
  int cartItemCount = 0;
  bool isInCart = false;

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

  void updateCartItemCount(int count) {
    setState(() {
      cartItemCount = count;
      isInCart = count > 0;
    });
  }

  void updateSelectedColor(int index) {
    setState(() {
      currentColor = index;
    });
  }

  Future<void> _refreshProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width > 600;

    final cartProvider = CartProvider.of(context, listen: false);
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
          child: Responsive(
            mobile: _buildMobileView(cartProvider, screenSize, isTablet),
            tablet: _buildTabletView(cartProvider, screenSize, isTablet),
            desktop: _buildDesktopView(cartProvider, screenSize, isTablet),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            right: -5,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: AddToCart(
                  product: widget.product,
                  updateCartCount: updateCartItemCount,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: isTablet ? 482 : 350,
            right: 0,
            child: FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(0.6),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBar(initialIndex: 3),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black.withOpacity(0.5),
                      size: 40,
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Positioned(
                        top: -3,
                        right: 0,
                        child: badges.Badge(
                          badgeAnimation: const badges.BadgeAnimation.scale(
                            animationDuration: Duration(seconds: 1),
                            colorChangeAnimationDuration: Duration(seconds: 1),
                            loopAnimation: false,
                            curve: Curves.fastOutSlowIn,
                            colorChangeAnimationCurve: Curves.easeInCubic,
                          ),
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: Colors.red,
                            padding: const EdgeInsets.all(5),
                            shape: badges.BadgeShape.circle,
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1),
                          ),
                          position:
                              badges.BadgePosition.topEnd(top: -8, end: -8),
                          badgeContent: Text(
                            '${cartProvider.cart.length}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          showBadge: cartProvider.cart.isNotEmpty,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileView(
      CartProvider cartProvider, Size screenSize, bool isTablet) {
    return Column(
      children: [
        DetailAppBar(
          product: widget.product,
          updateCartCount: updateCartItemCount,
        ),
        MyImageSlider(
          image: widget.product.image,
          onChange: (index) {
            setState(() {
              currentImage = index;
            });
          },
          pageController: _pageController,
          height: screenSize.height * 0.4,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemsDetails(product: widget.product),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 25),
                  Description(
                    description: widget.product.description,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletView(
      CartProvider cartProvider, Size screenSize, bool isTablet) {
    return _buildMobileView(cartProvider, screenSize, isTablet);
  }

  Widget _buildDesktopView(
      CartProvider cartProvider, Size screenSize, bool isTablet) {
    return _buildMobileView(cartProvider, screenSize, isTablet);
  }
}
