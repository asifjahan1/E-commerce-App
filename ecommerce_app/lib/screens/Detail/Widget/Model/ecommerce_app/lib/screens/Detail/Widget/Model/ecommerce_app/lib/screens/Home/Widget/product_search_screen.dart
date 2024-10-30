// ignore_for_file: library_private_types_in_public_api

import 'package:ecommerce_app/screens/Home/Widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product_model.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  List<Product> _allProducts = []; // Add your list of products here
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _allProducts = all; // Assign your all products list
    _filteredProducts = _allProducts;
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredProducts = _allProducts;
      });
    } else {
      setState(() {
        _filteredProducts = _allProducts.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Search'),
      ),
      body: Column(
        children: [
          MySearchBAR(onSearch: _filterProducts),
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(child: Text('Sorry, this product is not available'))
                : ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return ListTile(
                        title: Text(product.title),
                        subtitle: Text(product.description),
                        leading: Image.asset(product.image),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Assuming priceBDT and priceAED are non-nullable
                            Text('৳${product.priceBDT.toStringAsFixed(2)}'),
                            if (product.priceAED >
                                0) // Assuming priceAED is not nullable and > 0
                              Text(
                                  ' د.إ${product.priceAED.toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
