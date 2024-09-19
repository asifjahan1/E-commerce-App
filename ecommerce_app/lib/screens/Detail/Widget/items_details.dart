import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ItemsDetails extends StatelessWidget {
  final Product product;

  const ItemsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Star rating and review count
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .doc(product.id) // Product's ID
                          .collection('reviews')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData) {
                          // Default values for when no data is available or still loading
                          return Row(
                            children: [
                              // Rating Box
                              Container(
                                width: 55,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kprimaryColor,
                                ),
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      '0.0',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5),
                              // Review count
                              GestureDetector(
                                onTap: () {
                                  // Add functionality to show all reviews on tap if needed
                                },
                                child: const Text(
                                  "0 reviews",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        var reviews = snapshot.data!.docs;
                        double totalRating = 0;
                        for (var review in reviews) {
                          totalRating += review['rating'];
                        }

                        // Calculate average rating
                        double averageRating = reviews.isNotEmpty
                            ? totalRating / reviews.length
                            : 0;

                        return Row(
                          children: [
                            // Rating Box
                            Container(
                              width: 55,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: kprimaryColor,
                              ),
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    averageRating.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            // Review count
                            GestureDetector(
                              onTap: () {
                                // You can add functionality to show all reviews on tap
                              },
                              child: Text(
                                reviews.isNotEmpty
                                    ? "${reviews.length} reviews"
                                    : "0 reviews",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // Seller's name (if you want to display it)
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       const TextSpan(
            //         text: "Seller: ",
            //         style: TextStyle(fontSize: 16),
            //       ),
            //       TextSpan(
            //         text: product.seller,
            //         style: const TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
