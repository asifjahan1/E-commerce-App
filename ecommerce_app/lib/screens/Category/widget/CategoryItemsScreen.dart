import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Detail/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../models/product_model.dart';
import '../../../models/category.dart';

class CategoryItemsScreen extends StatefulWidget {
  final Category category;

  const CategoryItemsScreen({super.key, required this.category});

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = [];

    // Filter products based on the category selected
    if (widget.category.title == "All") {
      filteredProducts = all;
    } else if (widget.category.title == "Shoes") {
      filteredProducts = shoes;
    } else if (widget.category.title == "Beauty") {
      filteredProducts = beauty;
    } else if (widget.category.title == "Women's\nFashion") {
      filteredProducts = womenFashion;
    } else if (widget.category.title == "Jewelry") {
      filteredProducts = jewelry;
    } else if (widget.category.title == "Men's\nFashion") {
      filteredProducts = menFashion;
    } else if (widget.category.title == "Groceries") {
      filteredProducts = groceries;
    }

    // Check if there are no products in the filtered list
    if (filteredProducts.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            iconSize: 24.0,
          ),
          title: Text(widget.category.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            "No products available in this category",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
      );
    }

    // If there are products
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        leading: IconButton(
          style: IconButton.styleFrom(
            // backgroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 24.0,
        ),
        title: Text(widget.category.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(product: product),
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                // color: kcontentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Image.asset(
                      product.image,
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Price: ${product.priceBDT} BDT',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
