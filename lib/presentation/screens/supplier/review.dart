import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ReviewsView(),
      ),
    );
  }
}

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = ['1', '2', '3', '4', '5'];

    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final post = reviews[index];
        return ReviewCard(
          userName: 'Prueba',
          rating: 5,
          comment: 'Este es un ejemplo de reseña',
          date: '24/02/2024',
        );
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String userName;
  final double rating;
  final String comment;
  final String date;

  const ReviewCard({
    Key? key,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(4, 4),
            spreadRadius: 1,
          ),
          
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < rating ? Colors.amber : Colors.grey,
                size: 20,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            comment,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
