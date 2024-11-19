import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        title: const Text(
          "Category",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: categoriesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final category = categoriesList[index];
            return Card(
              color: kprimaryColor,
              shadowColor: kcontentColor,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    category.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                     ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
