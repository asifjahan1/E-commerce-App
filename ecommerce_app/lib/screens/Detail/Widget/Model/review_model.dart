import 'package:flutter/material.dart';

class Review {
  final String userName;
  final double rating;
  final String comment;
  final String? date; // Optional field for the review date
  final String? photoUrl; // Optional field for user photo

  Review({
    required this.userName,
    required this.rating,
    required this.comment,
    this.date,
    this.photoUrl,
  });

  // Convert review to JSON
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'rating': rating,
        'comment': comment,
        'date': date,
        'photoUrl': photoUrl,
      };

  // Create review from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      photoUrl: json['photoUrl'],
    );
  }
}
