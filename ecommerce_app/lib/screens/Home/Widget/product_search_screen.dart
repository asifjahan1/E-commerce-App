// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/Home/Widget/search_bar.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  List<Product> _allProducts = []; // Initialize your product list here
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _initializeProducts();
  }

  void _initializeProducts() {
    // Example initialization; replace with your actual product list
    _allProducts = all; // Assign your full product list here
    _filteredProducts = _allProducts;
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts = _allProducts
            .where((product) =>
                product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double padding = Responsive.isDesktop(context) ? 32.0 : 16.0;
    double imageSize = Responsive.isDesktop(context) ? 100.0 : 60.0;
    double fontSize = Responsive.isDesktop(context) ? 18.0 : 14.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Search'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          children: [
            MySearchBAR(onSearch: _filterProducts),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        'Sorry, this product is not available.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          child: ListTile(
                            leading: Image.asset(
                              product.image,
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              product.title,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              product.description,
                              style: TextStyle(fontSize: fontSize - 2),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '৳${product.priceBDT.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: fontSize, color: Colors.black),
                                ),
                                if (product.priceAED > 0)
                                  Text(
                                    'د.إ${product.priceAED.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: fontSize, color: Colors.grey),
                                  ),
                              ],
                            ),
                            onTap: () {
                              // Define navigation or action here
                              print("Selected: ${product.title}");
                            },
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
