class Review {
  final String userName;
  final double rating;
  final String comment;
  final String? date;
  final String? photoUrl;

  Review({
    required this.userName,
    required this.rating,
    required this.comment,
    this.date,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'rating': rating,
        'comment': comment,
        'date': date,
        'photoUrl': photoUrl,
      };

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
