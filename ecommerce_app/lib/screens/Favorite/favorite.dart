// ignore_for_file: unnecessary_null_comparison

import 'package:ecommerce_app/Provider/favorite_provider.dart';
import 'package:ecommerce_app/screens/Detail/details_screen.dart';
import 'package:flutter/material.dart';
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
    final provider = FavoriteProvider.of(context);
    final List<Product> finalList = provider.favorites;
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
              child: ListView.builder(
                itemCount: finalList.length,
                itemBuilder: (context, index) {
                  final Product favoriteItems = finalList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(product: favoriteItems),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 85,
                                  height: 85,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      favoriteItems.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      favoriteItems.category,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      favoriteItems.priceBDT != null
                                          ? "৳${favoriteItems.priceBDT.toStringAsFixed(2)}"
                                          : "د.إ${favoriteItems.priceAED.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          right: 35,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
