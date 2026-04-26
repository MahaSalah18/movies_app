import 'package:flutter/material.dart';
import 'package:movies_app/core/themes/colors/app_colors.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({super.key, required this.label});
   final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.textPrimary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.24), width: 0.8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color:AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}