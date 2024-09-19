import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class ReviewsAndRatingsPage extends StatefulWidget {
  final String productId;

  const ReviewsAndRatingsPage({super.key, required this.productId});

  @override
  State<ReviewsAndRatingsPage> createState() => _ReviewsAndRatingsPageState();
}

class _ReviewsAndRatingsPageState extends State<ReviewsAndRatingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        title: const Text("Reviews and Ratings"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .collection('reviews')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No reviews available"),
            );
          }

          var reviews = snapshot.data!.docs;
          double totalRating = 0;
          for (var review in reviews) {
            totalRating += review['rating'];
          }

          double averageRating =
              reviews.isNotEmpty ? totalRating / reviews.length : 0;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${reviews.length} reviews",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      var review = reviews[index];
                      return ListTile(
                        title: Text(review['review']),
                        subtitle: Text("Rating: ${review['rating']}"),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
