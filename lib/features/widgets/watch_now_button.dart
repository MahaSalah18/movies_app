import 'package:flutter/material.dart';
import 'package:movies_app/core/themes/colors/app_colors.dart';

class WatchNowButton extends StatelessWidget {
  const WatchNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      
        fixedSize: Size(150, 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: AppColors.primaryColor,
        // foregroundColor: AppColors.textPrimary,
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow, color: AppColors.textPrimary),
          Text(
            "Watch Now",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
