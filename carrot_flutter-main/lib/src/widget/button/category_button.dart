import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final String? title;

  const CategoryButton({
    super.key,
    this.onTap,
    required this.icon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Icon(
                icon,
                size: 16,
                color: Colors.grey[600],
              ),
            ),
            Visibility(visible: title != null, child: SizedBox(width: 8)),
            Text(
              title ?? '',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
