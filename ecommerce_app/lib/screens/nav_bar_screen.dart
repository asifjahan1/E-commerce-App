// ignore_for_file: library_private_types_in_public_api

import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/Category/category_items.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Cart/cart_screen.dart';
import 'package:ecommerce_app/screens/Home/home_screen.dart';
import 'package:ecommerce_app/screens/Profile/profile.dart';
import 'package:ecommerce_app/screens/Favorite/favorite.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({super.key, required this.initialIndex});

  static _BottomNavBarState? of(BuildContext context) =>
      context.findAncestorStateOfType<_BottomNavBarState>();

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex;
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  List screens = const [
    Category(),
    Favorite(),
    HomeScreen(),
    CartScreen(),
    Profile(),
  ];

  void updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void addToCart() {
    setState(() {
      cartItemCount++;
    });
  }

  void removeFromCart() {
    setState(() {
      if (cartItemCount > 0) {
        cartItemCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: kprimaryColor,
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Responsive(
        mobile: _buildBottomNavBar(context, 70, 30, 16),
        tablet: _buildBottomNavBar(context, 90, 35, 18),
        desktop: _buildBottomNavBar(context, 100, 40, 20),
      ),
      body: screens[currentIndex],
    );
  }

  Widget _buildBottomNavBar(
      BuildContext context, double height, double iconSize, double fontSize) {
    return BottomAppBar(
      elevation: 5,
      height: height,
      color: Colors.black,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavItem(0, Icons.grid_view_outlined, 'Category', iconSize, fontSize),
          buildNavItem(1, Icons.favorite_border, 'Favorite', iconSize, fontSize),
          const SizedBox(width: 8),
          buildCartNavItem(3, Icons.shopping_cart_outlined, 'Cart', iconSize, fontSize),
          buildNavItem(4, Icons.person, 'Account', iconSize, fontSize),
        ],
      ),
    );
  }

  Widget buildNavItem(int index, IconData icon, String label, double iconSize, double fontSize) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: currentIndex == index
            ? Text(
                label,
                style: TextStyle(
                  color: kprimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              )
            : Icon(
                icon,
                size: iconSize,
                color: currentIndex == index ? kprimaryColor : Colors.grey.shade400,
              ),
      ),
    );
  }

  Widget buildCartNavItem(int index, IconData icon, String label, double iconSize, double fontSize) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: badges.Badge(
          position: badges.BadgePosition.topEnd(top: -10, end: -10),
          showBadge: cartItemCount > 0,
          badgeContent: Text(
            '$cartItemCount',
            style: const TextStyle(color: Colors.white),
          ),
          child: currentIndex == index
              ? Text(
                  label,
                  style: TextStyle(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                )
              : Icon(
                  icon,
                  size: iconSize,
                  color: currentIndex == index ? kprimaryColor : Colors.grey.shade400,
                ),
        ),
      ),
    );
  }
}
