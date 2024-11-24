import 'package:flutter/material.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: List.generate(
            5, // Número de reseñas
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ReviewItem(
                username: "Usuario ${index + 1}",
                reviewText:
                    "Esta es una reseña de ejemplo. ¡Excelente servicio!",
                rating: 4.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String username;
  final String reviewText;
  final double rating;

  const ReviewItem({
    super.key,
    required this.username,
    required this.reviewText,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      // elevation: ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: colors.primary,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(reviewText),
          ],
        ),
      ),
    );
  }
}
