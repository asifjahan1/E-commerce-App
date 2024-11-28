// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';
import 'package:ecommerce_app/Provider/favorite_provider.dart';
import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/Detail/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'package:ecommerce_app/models/product_model.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  // Refresh action
  Future<void> _refreshProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Corrected the provider access
    final provider = Provider.of<FavoriteProvider>(context);
    final List<Product> finalList = provider.favorites;

    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent, // Make the background transparent
          elevation: 0, // Remove the shadow
          title: const Text(
            "Favorite",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Apply blur effect
              child: Container(
                color: kcontentColor.withOpacity(0.5), // Semi-transparent background
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        edgeOffset: 0.0,
        color: kprimaryColor,
        strokeWidth: 3,
        displacement: 40,
        child: Column(
          children: [
            Expanded(
              child: Responsive(
                mobile: buildListView(finalList, context, 1, provider),
                tablet: buildListView(finalList, context, 2, provider),
                desktop: buildListView(finalList, context, 3, provider),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // This method will build the list view based on the number of columns (for responsive design)
  Widget buildListView(List<Product> finalList, BuildContext context, int columns, FavoriteProvider provider) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 3.5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: finalList.length,
      itemBuilder: (context, index) {
        final Product favoriteItems = finalList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(product: favoriteItems),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: Responsive.isMobile(context) ? 85 : 100,
                      height: Responsive.isMobile(context) ? 85 : 100,
                      decoration: BoxDecoration(
                        color: kcontentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Hero(
                        tag: 'product-image-${favoriteItems.id}',
                        child: Image.asset(favoriteItems.image),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favoriteItems.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.isMobile(context) ? 14 : 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            favoriteItems.category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                              fontSize: Responsive.isMobile(context) ? 14 : 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            favoriteItems.priceBDT != null
                                ? "৳${favoriteItems.priceBDT.toStringAsFixed(2)}"
                                : "د.إ${favoriteItems.priceAED.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.isMobile(context) ? 14 : 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    provider.toggleFavorite(favoriteItems);
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
