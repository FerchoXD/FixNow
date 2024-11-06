import 'package:flutter/material.dart';

class BuildServiceTag extends StatelessWidget {
  final String service;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const BuildServiceTag(
    this.service, {
    super.key,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(isSelected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                service,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.check,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
