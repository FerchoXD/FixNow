import 'package:flutter/material.dart';

class ProviderCard extends StatelessWidget {
  final String name;
  final String profession;
  final int price;
  final int rating;

  const ProviderCard({
    super.key,
    required this.name,
    required this.profession,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius:
            BorderRadius.circular(15), 
            
     
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: colors.onSurface, fontWeight: FontWeight.w500),
                ),
                Text(
                  profession,
                  style: TextStyle(color: colors.onSurfaceVariant),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star_rounded : Icons.star_border_rounded,
                      color: colors.primary,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "A partir de",
                  style: TextStyle(color: colors.onSurface),
                ),
                Text(
                  '\$ $price',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colors.onSurface,
                      fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
