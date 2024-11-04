import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final double scaleFactor;

  const ActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.scaleFactor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4C98E9),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10 * scaleFactor)),
        padding: EdgeInsets.all(15 * scaleFactor),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10 * scaleFactor),
            height: 75 * scaleFactor,
            width: 73 * scaleFactor,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10 * scaleFactor),
            ),
            child: Icon(icon, color: Colors.white, size: 30 * scaleFactor),
          ),
          SizedBox(width: 20 * scaleFactor),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16 * scaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5 * scaleFactor),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14 * scaleFactor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
