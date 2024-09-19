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
