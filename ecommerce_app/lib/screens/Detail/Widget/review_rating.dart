import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReviewsAndRatingsPage extends StatefulWidget {
  final String productId;

  const ReviewsAndRatingsPage({super.key, required this.productId});

  @override
  State<ReviewsAndRatingsPage> createState() => _ReviewsAndRatingsPageState();
}

class _ReviewsAndRatingsPageState extends State<ReviewsAndRatingsPage> {
  final TextEditingController _commentController = TextEditingController();
  File? _selectedImage;
  List<Map<String, dynamic>> reviews = [];
  double _userRating = 5.0;

  Future<String> _getCurrentUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null
        ? user.displayName ?? user.email ?? 'Anonymous'
        : 'Anonymous';
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitReview() async {
    if (_commentController.text.isNotEmpty || _selectedImage != null) {
      String reviewText = _commentController.text;
      double rating = _userRating;

      String userName = await _getCurrentUserName();

      var newReview = {
        'user': userName,
        'review': reviewText,
        'rating': rating,
        'image': _selectedImage?.path,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .collection('reviews')
          .add(newReview);

      setState(() {
        _commentController.clear();
        _selectedImage = null;
        _userRating = 5.0; // Resetting to maximum rating
      });
    }
  }

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
      body: SingleChildScrollView(
        child: Responsive(
          mobile: _buildMobileView(),
          tablet: _buildTabletView(),
          desktop: _buildDesktopView(),
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .doc(widget.productId)
              .collection('reviews')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              var fetchedReviews = snapshot.data!.docs.map((doc) {
                return {
                  'user': doc['user'],
                  'review': doc['review'],
                  'rating': doc['rating'],
                  'image': doc['image'],
                };
              }).toList();

              if (reviews.length != fetchedReviews.length) {
                reviews = fetchedReviews;
              }
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.grey.withOpacity(0.1),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  reviews.isNotEmpty
                                      ? (reviews
                                                  .map((r) => r['rating'])
                                                  .reduce((a, b) => a + b) /
                                              reviews.length)
                                          .toStringAsFixed(1)
                                      : '0',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${reviews.length} reviews",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      var review = reviews[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['user'] ?? 'Unknown',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Rating: ${review['rating'].toStringAsFixed(1)}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(review['review']),
                          const SizedBox(height: 10),
                          if (review['image'] != null)
                            Center(
                              child: Image.file(
                                File(review['image']),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        _buildCommentAndImageUploadSection(),
      ],
    );
  }

  Widget _buildTabletView() {
    return _buildMobileView(); // You can customize it differently for tablets
  }

  Widget _buildDesktopView() {
    return _buildMobileView(); // You can customize it differently for desktops
  }

  Widget _buildCommentAndImageUploadSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: "Write a comment...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.star),
                      color: Colors.amber,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text("Rate this product"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Slider(
                                        value: _userRating,
                                        min: 1.0,
                                        max: 5.0,
                                        divisions: 4,
                                        label: _userRating.toString(),
                                        onChanged: (value) {
                                          setState(() {
                                            _userRating = value;
                                          });
                                        },
                                      ),
                                      Text(
                                          "Rating: ${_userRating.toStringAsFixed(1)}"),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple
                                              .withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.3),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "OK",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.photo,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      onPressed: _pickImage,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.deepPurple,
                      ),
                      onPressed: _submitReview,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
