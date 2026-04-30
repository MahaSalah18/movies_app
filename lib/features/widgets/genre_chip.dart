import 'package:flutter/material.dart';
class GenreChip extends StatelessWidget {
  const GenreChip({super.key, required this.label});
   final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.24) ?? Colors.transparent,
          width: 0.8,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}