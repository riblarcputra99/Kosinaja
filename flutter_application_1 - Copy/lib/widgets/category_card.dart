
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade200,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}
