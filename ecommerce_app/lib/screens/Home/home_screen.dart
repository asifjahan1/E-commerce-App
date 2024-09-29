import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/Home/Widget/product_cart.dart';
import 'package:ecommerce_app/screens/Home/Widget/search_bar.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';

import '../../models/category.dart';
import 'Widget/home_app_bar.dart';
import 'Widget/home_image_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;
  List<Product> _filteredProducts = all; // Initial product list is all products

  // Define selectcategories at the class level so it is accessible throughout the class
  List<List<Product>> selectcategories = [
    all,
    shoes,
    beauty,
    womenFashion,
    jewelry,
    menFashion
  ];

  // Callback method to handle avatar tap
  void _onAvatarTap() {
    // Navigate to the profile screen, which is index 4
    setState(() {
      BottomNavBar.of(context)?.updateIndex(4);
    });
  }

  // Method to handle search
  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = selectcategories[selectedIndex];
      } else {
        _filteredProducts = selectcategories[selectedIndex]
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // refresh action
  Future<void> _refreshProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // can perform any refresh actions here (e.g., reloading data)
      _filteredProducts = selectcategories[selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        edgeOffset: 1.0,
        // backgroundColor: Colors.transparent,
        displacement: 40,
        color: kprimaryColor,
        strokeWidth: 3,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                // custom appbar
                CustomAppBar(onAvatarTap: _onAvatarTap),
                const SizedBox(height: 20),
                // search bar
                MySearchBAR(onSearch: _filterProducts),
                const SizedBox(height: 20),
                ImageSlider(
                  currentSlide: currentSlider,
                  onChange: (value) {
                    setState(() {
                      currentSlider = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // for category selection
                categoryItems(),
                const SizedBox(height: 20),
                if (selectedIndex == 0)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Special For You",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                // for shopping items
                const SizedBox(height: 10),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: _filteredProducts.map((product) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      child: ProductCard(
                        product: product,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox categoryItems() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                // Prevent out of bounds error
                if (index < selectcategories.length) {
                  selectedIndex = index;
                  _filteredProducts = selectcategories[selectedIndex];
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedIndex == index
                    ? const Color(0xffF5F5F5)
                    : Colors.transparent,
              ),
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(categoriesList[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categoriesList[index].title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
