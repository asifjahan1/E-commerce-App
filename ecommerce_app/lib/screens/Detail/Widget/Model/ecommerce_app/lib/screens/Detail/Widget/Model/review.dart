// import 'package:cloud_firestore/cloud_firestore.dart';

// class Review {
//   final String userId;
//   final String userName;
//   final double rating;
//   final String comment;
//   final String? imageUrl;
//   final Timestamp timestamp;

//   Review({
//     required this.userId,
//     required this.userName,
//     required this.rating,
//     required this.comment,
//     this.imageUrl,
//     required this.timestamp,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'userName': userName,
//       'rating': rating,
//       'comment': comment,
//       'imageUrl': imageUrl,
//       'timestamp': timestamp,
//     };
//   }

//   factory Review.fromJson(Map<String, dynamic> json) {
//     return Review(
//       userId: json['userId'],
//       userName: json['userName'],
//       rating: json['rating'],
//       comment: json['comment'],
//       imageUrl: json['imageUrl'],
//       timestamp: json['timestamp'],
//     );
//   }
// }
//
//
//
//
class Review {
  final String userName;
  final double rating;
  final String comment;
  final String? photoUrl;

  Review({
    required this.userName,
    required this.rating,
    required this.comment,
    this.photoUrl,
  });
}

class Product {
  final String id;
  final String title;
  final String description;
  final List<String> colors;
  final List<String> images;
  final double price;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.colors,
    required this.images,
    required this.price,
    this.reviews = const [],
  });
}
