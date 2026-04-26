import 'package:flutter/material.dart';
import 'package:movies_app/core/themes/colors/app_colors.dart';

class MoreInfoButton extends StatelessWidget {
  const MoreInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.info_outline, size: 18),
      label: Text('More Info', style: TextStyle(fontWeight: FontWeight.bold)),
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.buttonSecondary,
        foregroundColor: AppColors.textPrimary,
        fixedSize: Size(130, 30),
        side: const BorderSide(color: Colors.white38),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
