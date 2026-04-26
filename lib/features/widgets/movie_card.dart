import 'package:flutter/material.dart';
import 'package:movies_app/core/themes/colors/app_colors.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/features/widgets/rating_badge.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
  });
  final Movie movie;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الفيلم مع التقييم
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.network(
                  movie.imageUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: width,
                    height: height,
                    color: AppColors.errorBuilder,
                    child: const Icon(
                      Icons.movie,
                      color: AppColors.iconColor,
                      size: 40,
                    ),
                  ),
                ),
                // Rating badge في الركن
                Positioned(
                  top: 8,
                  right: 8,
                  child: RatingBadge(rating: movie.rating, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // اسم الفيلم
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
