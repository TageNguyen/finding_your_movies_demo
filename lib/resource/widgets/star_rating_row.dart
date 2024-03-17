import 'package:flutter/material.dart';

class StarRatingRow extends StatelessWidget {
  final double rating;

  const StarRatingRow({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    int halfStars = ((rating - fullStars) >= 0.5) ? 1 : 0;
    int grayStars = 10 - fullStars - halfStars;

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        if (halfStars == 1)
          const Icon(
            Icons.star_half,
            color: Colors.yellow,
          ),
        for (int i = 0; i < grayStars; i++)
          Icon(
            Icons.star_border,
            color: Colors.grey[400],
          ),
      ],
    );
  }
}
