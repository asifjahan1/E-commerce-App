// ignore_for_file: file_names

import 'package:ecommerce_app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryItemsScreen extends StatefulWidget {
  const CategoryItemsScreen({super.key, required Category category});

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
