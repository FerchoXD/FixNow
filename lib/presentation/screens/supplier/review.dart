import 'package:fixnow/presentation/providers/raiting/raiting_provider.dart';
import 'package:fixnow/presentation/providers/supplier/supplier_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewsView extends ConsumerWidget {
  final String supplierId;
  const ReviewsView({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierState = ref.watch(supplierProfileProvider(supplierId));

    return ListView.builder(
      shrinkWrap: true, // Ajusta el tamaño al contenido
      physics: const NeverScrollableScrollPhysics(),
      itemCount: supplierState.reviews.length,
      itemBuilder: (context, index) {
        final review = supplierState.reviews[index];
        return supplierState.reviews.isEmpty
            ? Center(
                child: Text('Aún no hay reseñas'),
              )
            : ReviewCard(
                userName: review['fullname'],
                rating: review['polarity'],
                comment: review['content'],
              );
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String userName;
  final double rating;
  final String comment;

  const ReviewCard({
    Key? key,
    required this.userName,
    required this.rating,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Determinar si es una reseña de 0 estrellas
    bool isZeroRating = rating == 0.0;

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
                style:  TextStyle(
                  fontSize: 18,
                  fontWeight: isZeroRating ? FontWeight.normal : FontWeight.w500,
                  color: isZeroRating ? Colors.black26 : Colors.black
                ),
              ),
            ],
          ),
          Row(
            children: List.generate(
              5,
              (index) {
                // Si la calificación es 0, usa un color transparente
                return Icon(
                  Icons.star,
                  color: isZeroRating
                      ? Colors.black26 // Hacer las estrellas transparentes
                      : (index < rating ? Colors.amber : Colors.black12),
                  size: 20,
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            comment,
            style: TextStyle(
              fontSize: 16,
              color: isZeroRating ? Colors.black26 :  Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
